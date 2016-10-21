%% Copyright (C) 2014-2016 Colin B. Macdonald
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
%% @deftypeop  Method   @@sym {@var{f} =} subsasgn (@var{f}, @var{idx}, @var{rhs})
%% @deftypeopx Operator @@sym {} {@var{f}(@var{i}) = @var{rhs}} {}
%% @deftypeopx Operator @@sym {} {@var{f}(@var{i}, @var{j}) = @var{rhs}} {}
%% @deftypeopx Operator @@sym {} {@var{f}(@var{i}:@var{j}) = @var{rhs}} {}
%% @deftypeopx Operator @@sym {} {@var{f}(@var{x}) = @var{symexpr}} {}
%% Assign to entries of a symbolic array.
%%
%% Examples:
%% @example
%% @group
%% A = sym([10 11 12]);
%% A(3) = 44
%%   @result{} A = (sym) [10  11  44]  (1×3 matrix)
%%
%% A(1:2) = [42 43]
%%   @result{} A = (sym) [42  43  44]  (1×3 matrix)
%%
%% A(1, 1) = 41
%%   @result{} A = (sym) [41  43  44]  (1×3 matrix)
%% @end group
%% @end example
%%
%% This method also gets called when creating @@symfuns:
%% @example
%% @group
%% syms x
%% f(x) = 3*x^2
%%   @result{} f(x) = (symfun)
%%          2
%%       3⋅x
%% @end group
%% @end example
%%
%% @seealso{@@sym/subsref, @@sym/subindex, @@sym/end, symfun}
%% @end deftypeop

function out = subsasgn (val, idx, rhs)

  if strcmp(idx.type, '.') && ischar(idx.subs)
    out = builtin('subsasgn', val, idx, rhs);
  else
    out = subsasgn(val, idx, rhs)
  end

end
