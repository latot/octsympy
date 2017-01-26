%% Copyright (C) 2017 Lagu
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
%% @defmethod @@sym issubset (@var{x}, @var{y})
%% Returns True if @var{x} is a subset of @var{y}.
%%
%% Example:
%% @example
%% @group
%% a = interval (sym (0), sym (1)/2);
%% b = interval (sym (0), 1);
%% issubset (a, b)
%%   @result{} ans = 1
%% @end group
%% @end example
%%
%% @end defmethod


function y = issubset(x, y)
  if (nargin ~= 2)
    print_usage ();
  end
  y = elementwise_op ('lambda x, y: x.is_subset(y)', sym (x), sym (y));
end


%!test
%! a = interval (sym (0), sym (1)/2);
%! b = interval (sym (0), 1);
%! assert (logical (issubset (a, b)))

%!test
%! a = interval (sym (0), 1);
%! b = interval (sym (0), 1, true);
%! assert (logical (~issubset (a, b)))