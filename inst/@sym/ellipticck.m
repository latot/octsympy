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
%% @defmethod @@sym ellipticck (@var{m})
%% Complete elliptic integral of the first kind.
%%
%% Example:
%% @example
%% @group
%% syms m
%% ellipticck (m)
%%   @result{} ans = (sym)
%%       π                        
%%       ─                        
%%       2                        
%%       ⌠                        
%%       ⎮          1             
%%       ⎮ ──────────────────── dα
%%       ⎮    _________________   
%%       ⎮   ╱        2           
%%       ⎮ ╲╱  - m⋅sin (α) + 1    
%%       ⌡                        
%%       0
%% @end group
%% @group
%% double (ellipticck (sym (-pi)))
%%   @result{} ans =  1.0673
%% @end group
%% @end example
%%
%% @seealso{@@sym/ellipticf, @@sym/ellipticpi}
%% @end defmethod


function y = ellipticck(m)
  if nargin > 1
    print_usage();
  end
  
  y = ellipticf (sym(pi)/2, m);

end
