From: romain.perier@gmail.com (Romain Perier)
Date: Fri, 13 Mar 2015 14:20:56 +0100
Subject: [PATCH 5/8] ARM: dts: rockchip: relicense rk3288-thermal.dtsi
 under GPLv2/X11
In-Reply-To: <1425665046-22927-6-git-send-email-heiko@sntech.de>
References: <1425665046-22927-1-git-send-email-heiko@sntech.de>
 <1425665046-22927-6-git-send-email-heiko@sntech.de>
Message-ID: <CABgxDoJXg3_7C6ZX5B+Ug2--VrHWKQL9krg3n-m5cXZ+Q6F1wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: romain.perier at gmail.com

2015-03-06 19:04 GMT+01:00 Heiko Stuebner <heiko@sntech.de>:
> GPLv2-only devicetrees make reuse difficult for software components licensed
> under a different license.
>
> The consensus is that a GPL/X11 dual-license should allow all necessary uses,
> so relicense the rk3288-thermal.dtsi to this combination.
>
> CCs were aquired by git shortlog -sne so it should've hopefully catched
> every contributor.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Cc: Caesar Wang <caesar.wang@rock-chips.com>
> ---
> I'm hoping to get Acked-by tags from the people in the Cc-list.
>
>  arch/arm/boot/dts/rk3288-thermal.dtsi | 40 ++++++++++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/rk3288-thermal.dtsi b/arch/arm/boot/dts/rk3288-thermal.dtsi
> index 2695200..3404066 100644
> --- a/arch/arm/boot/dts/rk3288-thermal.dtsi
> +++ b/arch/arm/boot/dts/rk3288-thermal.dtsi
> @@ -3,9 +3,43 @@
>   *
>   * Copyright (c) 2014, Fuzhou Rockchip Electronics Co., Ltd
>   *
> - * This file is licensed under the terms of the GNU General Public License
> - * version 2.  This program is licensed "as is" without any warranty of any
> - * kind, whether express or implied.
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
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
>  #include <dt-bindings/thermal/thermal.h>
> --
> 2.1.4
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
