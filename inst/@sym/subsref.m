%% Copyright (C) 2014, 2016 Colin B. Macdonald
%%
%% This file is part of OctSymPy.
%%
%% OctSymPy is free software; you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published
%% by the Free Software Foundation; either version 3 of the License,
%% or (at your option) any later version.
%%
%% This software is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty
%% of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
%% the GNU General Public License for more details.
%%
%% You should have received a copy of the GNU General Public
%% License along with this software; see the file COPYING.
%% If not, see <http://www.gnu.org/licenses/>.

%% -*- texinfo -*-
%% @documentencoding UTF-8
%% @defop  Method   @@sym subsref {(@var{f}, @var{idx})}
%% @defopx Operator @@sym {@var{f}(@var{i})} {}
%% @defopx Operator @@sym {@var{f}(@var{i}, @var{j})} {}
%% @defopx Operator @@sym {@var{f}(@var{i}:@var{j})} {}
%% @defopx Operator @@sym {@var{f}.property} {}
%% Access entries of a symbolic array.
%%
%% Examples:
%% @example
%% @group
%% A = sym([10 11 12]);
%% A(2)
%%   @result{} (sym) 11
%%
%% A(2:3)
%%   @result{} (sym) [11  12]  (1×2 matrix)
%%
%% A(1, 1)
%%   @result{} (sym) 10
%% @end group
%%
%% @group
%% A.flat
%%   @result{} Matrix([[10, 11, 12]])
%% @end group
%% @end example
%%
%% @seealso{@@sym/subsasgn, @@sym/subsindex, @@sym/end}
%% @end defop

function out = subsref (f, idx)

  switch idx.type
    case '()'
      % sym(sym) indexing gets here
      for i = 1:length(idx.subs)
        if (isa(idx.subs{i}, 'sym'))
          idx.subs{i} = subsindex(idx.subs{i})+1;
        end
      end
      for i = 1:length(idx.subs)
        if (~ sym.is_valid_index(idx.subs{i}))
          error('OctSymPy:subsref:invalidIndices', ...
                'invalid indices: should be integers or boolean');
        end
      end
      out = sym.mat_access(f, idx.subs);

    case '.'
      out = f.(idx.subs);

    otherwise
      error ('@sym/subsref: invalid subscript type ''%s''', idx.type);

  end

end


%!shared a,b
%! b = [1:4];
%! a = sym(b);
%!assert(isequal( a(1), b(1) ))
%!assert(isequal( a(2), b(2) ))
%!assert(isequal( a(4), b(4) ))
%!assert(isempty( a([]) ))

%!shared a,b
%! b = [1:4];  b = [b; 3*b; 5*b];
%! a = sym(b);
%!assert(isequal( a(1), b(1) ))
%!assert(isequal( a(2), b(2) ))
%!assert(isequal( a(4), b(4) ))
%!assert(isequal( a(:,:), a ))
%!assert(isequal( a(1:2,1:3), a(1:2,1:3) ))
%!assert(isequal( a(1:2:3,[1 2 4]), b(1:2:3,[1 2 4]) ))
%!assert(isequal( a(1:2:3,[4 2 3 1]), b(1:2:3,[4 2 3 1]) ))
% repeats
%!assert(isequal( a(1:2:3,[4 1 1 1]), b(1:2:3,[4 1 1 1]) ))

%!assert(isequal( a([],:), b([],:) ))
%!assert(isequal( size(a([],:)), [0 4] ))
%!assert(isequal( a(1:2,[]), b(1:2,[]) ))
%!assert(isequal( size(a(1:2,[])), [2 0] ))
%!assert(isempty( a(1:2,[]) ))
%!assert(isempty( a([],[]) ))
%!assert(isequal( a([],[]), sym([]) ))
%!assert(~isequal( a(1:2,[]), sym([]) ))

%!shared e
%! e = sym([1 3 5; 2 4 6]);
%!assert(isequal( e(:), sym((1:6)') ))
%!assert(isequal( e([1 2 3]), sym([1 2 3]) ))
%!assert(isequal( e([1; 3; 4]), sym([1; 3; 4]) ))
%!assert(isempty( e([]) ))
%!assert(isempty( e('') ))
%!assert(isequal( e([]), sym([]) ))


%!shared a,b
%! b = 1:5; a = sym(b);
%!assert(isequal(  a([1 2 5]),  b([1 2 5])  ))
%!assert(isequal(  a([1; 2; 5]),  b([1; 2; 5])  ))

%!shared x
%! syms x

%!test
%! % logical with empty result
%! assert(isempty( x(false) ))
%! a = [x x];
%! assert(isempty( a([false false]) ))

%!test
%! % issue 18, scalar access
%! assert(isequal( x(1), x ))
%! assert(isequal( x(true), x ))

%!shared

%!test
%! % older access tests
%! syms x
%! f = [x 2; 3 4*x];
%! % element access
%! assert (logical(  f(1,1) == x  ))
%! assert (logical(  f(1,2) == 2  ))
%! % linear access of 2d array
%! assert (logical(  f(1) == x  ))
%! assert (logical(  f(2) == 3  ))  % column based
%! assert (logical(  f(3) == 2  ))

%!shared a,b
%! % effectively a random matrix
%! a = reshape( round(50*(sin(1:20)+1)),  5,4);
%! b = sym(a);

%!test
%! % older array refs test
%! assert (logical(b(1,1) == a(1,1)))
%! assert (logical(b(3,1) == a(3,1)))
%! assert (logical(b(1,3) == a(1,3)))
%! assert (logical(b(4,4) == a(4,4)))

%!test
%! % older array refs test: linear indices
%! assert (logical(b(1) == a(1)))
%! assert (logical(b(3) == a(3)))
%! assert (logical(b(13) == a(13)))

%!test
%! % older array refs test: end
%! assert (all(all(logical(  b(end,1) == a(end,1)  ))))
%! assert (all(all(logical(  b(2,end) == a(2,end)  ))))
%! assert (all(all(logical(  b(end,end) == a(end,end)  ))))
%! assert (all(all(logical(  b(end-1,1) == a(end-1,1)  ))))
%! assert (all(all(logical(  b(2,end-1) == a(2,end-1)  ))))
%! assert (all(all(logical(  b(end-1,end-1) == a(end-1,end-1)  ))))

%!shared

%!test
%! % older slicing tests
%! syms x
%! a = [1 2 3 4 5 6]; a = [a; 3*a; 5*a; 2*a; 4*a];
%! b = sym(a);
%! assert (isequal(  b(:,1), a(:,1)  ))
%! assert (isequal(  b(:,2), a(:,2)  ))
%! assert (isequal(  b(1,:), a(1,:)  ))
%! assert (isequal(  b(2,:), a(2,:)  ))
%! assert (isequal(  b(:,:), a(:,:)  ))
%! assert (isequal(  b(1:3,2), a(1:3,2)  ))
%! assert (isequal(  b(1:4,:), a(1:4,:)  ))
%! assert (isequal(  b(1:2:5,:), a(1:2:5,:)  ))
%! assert (isequal(  b(1:2:4,:), a(1:2:4,:)  ))
%! assert (isequal(  b(2:2:4,3), a(2:2:4,3)  ))
%! assert (isequal(  b(2:2:4,3), a(2:2:4,3)  ))

%!test
%! % 2D arrays
%! b = [1:4]; b = [b; 3*b; 5*b];
%! a = sym(b);
%! I = rand(size(b)) > 0.5;
%! assert (isequal (a(I), b(I)))
%! I = I(:);
%! s = warning ('off', 'OctSymPy:subsref:index_matrix_not_same_shape');
%! assert (isequal (a(I), b(I)))
%! I = I';
%! assert (isequal (a(I), b(I)))
%! warning (s)
%! I = logical(zeros(size(b)));
%! assert (isequal (a(I), b(I)))

%!warning <not same shape>
%! % some warnings when I is wrong shape
%! r = [1:6];
%! ar = sym(r);
%! c = r';
%! ac = sym(c);
%! Ir = rand(size(r)) > 0.5;
%! temp = ac(Ir);

%!warning <not same shape>
%! % some warnings when I is wrong shape
%! r = [1:6];
%! ar = sym(r);
%! c = r';
%! ac = sym(c);
%! Ic = rand(size(c)) > 0.5;
%! temp = ar(Ic);

%!test
%! % 1D arrays, does right with despite warning
%! r = [1:6];
%! ar = sym(r);
%! c = r';
%! ac = sym(c);
%! Ir = rand(size(r)) > 0.5;
%! Ic = rand(size(c)) > 0.5;
%! assert (isequal (ar(Ir), r(Ir)))
%! assert (isequal (ac(Ic), c(Ic)))
%! s = warning ('off', 'OctSymPy:subsref:index_matrix_not_same_shape');
%! assert (isequal (ar(Ic), r(Ic)))
%! assert (isequal (ac(Ir), c(Ir)))
%! warning (s)

%!test
%! % rccross tests
%! B = [1 2 3 4; 5 6 7 9; 10 11 12 13];
%! A = sym(B);
%! assert (isequal (A([1 3],[2 3]), B([1 3], [2 3])  ))
%! assert (isequal (A(1,[2 3]), B(1,[2 3])  ))
%! assert (isequal (A([1 2],4), B([1 2],4)  ))
%! assert (isequal (A([2 1],[4 2]), B([2 1],[4 2])  ))
%! assert (isequal (A([],[]), B([],[])  ))

%!error <integers>
%! % issue #445
%! A = sym([10 11]);
%! A(1.1)

%!error <integers>
%! % issue #445
%! A = sym([10 11]);
%! A(sym(4)/3)

%!error <integers>
%! % issue #445
%! A = sym([1 2; 3 4]);
%! A(1.1, 1)

%!error <integers>
%! % issue #445
%! A = sym([1 2; 3 4]);
%! A(1, sym(4)/3)
