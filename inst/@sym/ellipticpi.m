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
%% @defmethod @@sym y = ellipticpi (@var{n}, @var{m})
%% @defmethodx @@sym y = ellipticpi (@var{n}, @var{phi}, @var{m})
%% Complete elliptic integrals of the first and second kinds.
%%
%% Example incomplete elliptic integral of the second kind:
%% @example
%% @group
%% syms n phi m
%% ellipticpi (n, phi, m)
%%   @result{} ans = (sym)
%%       φ                                          
%%       ⌠                                          
%%       ⎮                   1                      
%%       ⎮ ────────────────────────────────────── dα
%%       ⎮    _________________                     
%%       ⎮   ╱        2         ⎛       2       ⎞   
%%       ⎮ ╲╱  - m⋅sin (α) + 1 ⋅⎝- n⋅sin (α) + 1⎠   
%%       ⌡                                          
%%       0 
%% @end group
%% @group
%% double (ellipticpi (sym (1), sym (1)/10, sym (1)/2))
%%   @result{} ans =  0.10042
%% @end group
%% @end example
%% Example complete elliptic integral of the second kind:
%% @example
%% @group
%% ellipticpi (n, m)
%%   @result{} ans = (sym)
%%       π                                          
%%       ─                                          
%%       2                                          
%%       ⌠                                          
%%       ⎮                   1                      
%%       ⎮ ────────────────────────────────────── dα
%%       ⎮    _________________                     
%%       ⎮   ╱        2         ⎛       2       ⎞   
%%       ⎮ ╲╱  - m⋅sin (α) + 1 ⋅⎝- n⋅sin (α) + 1⎠   
%%       ⌡                                          
%%       0 
%% @end group
%% @group
%% double (ellipticpi (sym (pi)/4, sym(pi)/8))
%%   @result{} ans =  4.0068
%% @end group
%% @end example
%%
%% @end defmethod


function y = ellipticpi(n, phi, m)

  switch nargin
    case 2
      y = ellipticpi (n, sym(pi)/2, phi);
    case 3
      assert (~ismember (sym ('alpha'), {phi, m}), 'You can not use alpha symbol in this function.')
      cmd = {'def _op(a, b, c):'
             '    m = Symbol("alpha")'
             '    return Integral(1/((1-a*sin(m)**2)*sqrt(1-c*sin(m)**2)), (m, 0, b))'};
      y = triop_helper (sym(n), sym(phi), sym(m), cmd);
    otherwise
      print_usage();
  end

end
