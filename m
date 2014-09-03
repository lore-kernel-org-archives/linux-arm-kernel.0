From: rbyshko@gmail.com (Roman B.)
Date: Wed, 3 Sep 2014 11:22:16 +0200
Subject: [PATCH 1/5] ARM: sun4i: Relicense the A10 DTSI under GPLv2/X11
In-Reply-To: <1409682069-7164-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1409682069-7164-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAMXmWBmuf650v=fYSc-JJ6JEhBPKxawng+XmUHvwH8Oi_YWpgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 2, 2014 at 8:21 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The current GPL only licensing on the DTSI makes it very impractical for other
> software components licensed under another license.
>
> In order to make it easier for them to reuse our device trees, relicense our
> DTSI first under a GPL/X11 dual-license. Hopefully, the DTS will follow soon.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Carlo Caione <carlo.caione@gmail.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
> Cc: Emilio L?pez <emilio@elopez.com.ar>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Oliver Schinagl <oliver@schinagl.nl>
> Cc: Roman Byshko <rbyshko@gmail.com>
> Cc: Stefan Roese <sr@denx.de>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 46 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 41 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index 380f914b226d..d12d36c470bc 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -2,12 +2,48 @@
>   * Copyright 2012 Stefan Roese
>   * Stefan Roese <sr@denx.de>
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
> + *  a) This library is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This library is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + *     You should have received a copy of the GNU General Public
> + *     License along with this library; if not, write to the Free
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
>  /include/ "skeleton.dtsi"
> --
> 2.0.2
>

For the whole series

Acked-by: Roman Byshko <rbyshko@gmail.com>
