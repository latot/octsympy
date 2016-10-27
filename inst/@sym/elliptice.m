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
%% @defmethod @@sym elliptice (@var{m})
%% @defmethodx @@sym elliptice (@var{phi}, @var{m})
%% Complete and incomplete elliptic integrals of the second kind.
%%
%% Example incomplete elliptic integral of the second kind:
%% @example
%% @group
%% syms phi m
%% elliptice (phi, m)
%%   @result{} ans = (sym)
%%       φ                        
%%       ⌠                        
%%       ⎮    _________________   
%%       ⎮   ╱        2           
%%       ⎮ ╲╱  - m⋅sin (α) + 1  dα
%%       ⌡                        
%%       0 
%% @end group
%% @group
%% double (elliptice (sym (1), sym (1)/10))
%%   @result{} ans =  0.98621
%% @end group
%% @end example
%% Example complete elliptic integral of the second kind:
%% @example
%% @group
%% elliptice (m)
%%   @result{} ans = (sym)
%%       π                        
%%       ─                        
%%       2                        
%%       ⌠                        
%%       ⎮    _________________   
%%       ⎮   ╱        2           
%%       ⎮ ╲╱  - m⋅sin (α) + 1  dα
%%       ⌡                        
%%       0 
%% @end group
%% @group
%% double (elliptice (sym (1)/10))
%%   @result{} ans =  1.5308
%% @end group
%% @end example
%%
%% @end defmethod


function y = elliptice(phi, m)

  switch nargin
    case 1
      y = elliptice (sym(pi)/2, phi);
    case 2
      assert (~ismember (sym ('alpha'), {phi, m}), 'You can not use alpha symbol in this function.')
      cmd = {'def _op(a, b):'
             '    m = Symbol("alpha")'
             '    return Integral(sqrt(1-b*sin(m)**2), (m, 0, a))'};
      y = binop_helper (sym (phi), sym (m), cmd);
    otherwise
      print_usage ();
  end

end
