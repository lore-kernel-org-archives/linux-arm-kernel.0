From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 17 Oct 2014 11:54:22 +0200
Subject: [PATCH 20/26] ARM: sun7i: cubietruck: Relicense the device tree
 under GPLv2/X11
In-Reply-To: <1413538728-17705-20-git-send-email-maxime.ripard@free-electrons.com>
References: <1413538728-17705-1-git-send-email-maxime.ripard@free-electrons.com>
 <1413538728-17705-20-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20141017095421.GB22855@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/10/2014 at 11:38:42 +0200, Maxime Ripard wrote :
> The current GPL only licensing on the DTSI makes it very impractical for other
> software components licensed under another license.
> 
> In order to make it easier for them to reuse our device trees, relicense our
> device trees under a GPL/X11 dual-license.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> Cc: Alexander Bersenev <bay@hackerdom.ru>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Carlo Caione <carlo@caione.org>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Oliver Schinagl <oliver@schinagl.nl>
> ---
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 46 ++++++++++++++++++++++++++----
>  1 file changed, 41 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> index a6c1a3c717bc..e1a642b207db 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> @@ -3,12 +3,48 @@
>   *
>   * Oliver Schinagl <oliver@schinagl.nl>
>   *
> - * The code contained herein is licensed under the GNU General Public
> - * License. You may obtain a copy of the GNU General Public License
> - * Version 2 or later at the following locations:
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
>   *
> - * http://www.opensource.org/licenses/gpl-license.html
> - * http://www.gnu.org/copyleft/gpl.html
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + *     You should have received a copy of the GNU General Public
> + *     License along with this file; if not, write to the Free
> + *     Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
> + *     MA 02110-1301 USA
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
>   */
>  
>  /dts-v1/;
> -- 
> 2.1.1
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
