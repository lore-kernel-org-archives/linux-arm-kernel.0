From: hl@rock-chips.com (hl)
Date: Fri, 15 May 2015 08:50:33 +0800
Subject: [PATCH 4/8] ARM: dts: rockchip: relicense rk3288.dtsi under
 GPLv2/X11
In-Reply-To: <1425665046-22927-5-git-send-email-heiko@sntech.de>
References: <1425665046-22927-1-git-send-email-heiko@sntech.de>
 <1425665046-22927-5-git-send-email-heiko@sntech.de>
Message-ID: <555542D9.3030909@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2015?03?07? 02:04, Heiko Stuebner wrote:
> GPLv2-only devicetrees make reuse difficult for software components licensed
> under a different license.
>
> The consensus is that a GPL/X11 dual-license should allow all necessary uses,
> so relicense the rk3288.dtsi to this combination.
>
> CCs were aquired by git shortlog -sne so it should've hopefully catched
> every contributor.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Addy Ke <addy.ke@rock-chips.com>
> Cc: Daniel Kurtz <djkurtz@chromium.org>
> Cc: Andy Yan <andy.yan@rock-chips.com>
> Cc: Caesar Wang <caesar.wang@rock-chips.com>
> Cc: Chris Zhong <zyw@rock-chips.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Jianqun Xu<jay.xu@rock-chips.com>
> Cc: Roger Chen <roger.chen@rock-chips.com>
> Cc: Sonny Rao <sonnyrao@chromium.org>
> Cc: Yunzhi Li <lyz@rock-chips.com>
> Cc: huang lin <hl@rock-chips.com>
>
> Not sure if an Ack for a simple revert is necessary, but included anyway
> Cc: Olof Johansson <olof@lixom.net>
> ---
> I'm hoping to get Acked-by tags from the people in the Cc-list.
>
>   arch/arm/boot/dts/rk3288.dtsi | 44 +++++++++++++++++++++++++++++++++++--------
>   1 file changed, 36 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 2c29a3e..35a06a5 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -1,13 +1,41 @@
>   /*
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
>    *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
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
>    */
>   
>   #include <dt-bindings/gpio/gpio.h>
Acked-by: Lin Huang <hl@rock-chips.com>

-- 
??
???????????
Fuzhou Rockchip Electronics Co.Ltd
?????????????89????A?21??(350003)
Addr:No.21 Building, A District, No.89, software Boulevard Fuzhou, Fujian,PRC
Email:hl at rock-chips.com
Tel:+86-591-83991906/07
  
****************************************************************************************
????????????????????????????????????????????
???? ????????????????????????????????????????
????????????????????????????????????????????
??????????????????
  
IMPORTANT NOTICE: This email is from Fuzhou Rockchip Electronics Co., Ltd .The contents
of this email and any attachments may contain information that is privileged, confidential
and/or exempt from disclosure under applicable law and relevant NDA. If you are not the
intended recipient, you are hereby notified that any disclosure, copying, distribution,
or use of the information is STRICTLY PROHIBITED. Please immediately contact the sender
as soon as possible and destroy the material in its entirety in any format. Thank you.
********************************************************************************
