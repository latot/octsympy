%% Copyright (C) 2016 Lagu
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
%% @defmethod @@sym zeros (@var{n})
%% @defmethodx @@sym zeros (@var{n}, @var{m})
%% @defmethodx @@sym zeros (@var{n}, @var{m}, @var{class})
%% Return a matrix or @var{n}-dimensional array whose elements are all 0.
%%
%% Example:
%% @example
%% @group
%% y = zeros (sym(3))
%%   @result{} y = (sym 3×3 matrix)
%%  ⎡0  0  0⎤
%%  ⎢       ⎥
%%  ⎢0  0  0⎥
%%  ⎢       ⎥
%%  ⎣0  0  0⎦
%% @end group
%% @end example
%%
%% @seealso{@@sym/ones}
%% @end defmethod

%% Source: http://docs.sympy.org/dev/modules/matrices/matrices.html

function y = zeros(varargin)

  s = false;
  t = isa(varargin{nargin}, 'char');
  n = nargin - double(t);

  if n == nargin
    for i=1:nargin
      if isa(varargin{i}, 'sym')
        s = true;
        break;
      end
    end
  else
    if strcmp(varargin{nargin}, 'sym')
      s = true;
    end
  end  

  if s
    if n == 1 && t
      y = python_cmd('return zeros(*_ins),', sym(varargin{1}));
    elseif n == 1
      y = python_cmd('return zeros(*_ins),', sym(varargin{:}));
    elseif t
      y = sym([builtin('zeros', cell2nosyms({varargin{1:n}}){:})]);
    else
      y = sym([builtin('zeros', cell2nosyms(varargin){:})]);
    end
  else
    y = [builtin('zeros', cell2nosyms(varargin){:})];
  end

end


%!test
%! y = zeros(sym(2));
%! x = [0 0;0 0];
%! assert( isequal( y, sym(x)))

%!test
%! y = zeros(sym(2), 1);
%! x = [0;0];
%! assert( isequal( y, sym(x)))

%!test
%! y = zeros(sym(1), 2);
%! x = [0 0];
%! assert( isequal( y, sym(x)))

%!test
%! %% Check types:
%! assert( isa( zeros(sym(2), 'double'), 'double'))
%! assert( isa( zeros(3, sym(3), 'single') , 'single'))
%! assert( isa( zeros(3, sym(3)), 'sym'))
%! assert( isa( zeros(3, sym(3), 'sym'), 'sym'))
%! assert( isa( zeros(3, 3, 'sym'), 'sym'))
