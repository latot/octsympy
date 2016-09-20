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
%% @defmethod @@sym zeros (@var{n}, @var{m})
%% @defmethod @@sym zeros (@var{n}, @var{m}, @var{class})
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
  if (nargin >= 2)
    for i=1:size(varargin)(2)
      if (ischar(varargin{i}))
        y = sym(zeros(cell2nosyms(varargin){:}));
        return;
      end
    end
  end

  if (nargin > 2)
    y = sym(zeros(cell2nosyms(varargin){:}));
    return;
  end

  %% Be careful, varargin should be always sym
  y = python_cmd('return zeros(*_ins),', sym(varargin){:});
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
