From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 16 Apr 2015 13:08:56 +0300
Subject: [PATCH v2 3/4] ARM: dts: UniPhier: add support for UniPhier SoCs
 and boards
In-Reply-To: <1429171147-19464-4-git-send-email-yamada.masahiro@socionext.com>
References: <1429171147-19464-1-git-send-email-yamada.masahiro@socionext.com>
 <1429171147-19464-4-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20150416100856.GJ30380@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masahiro Yamada,

On Thu, Apr 16, 2015 at 04:59:06PM +0900, Masahiro Yamada wrote:
> Initial device trees for UniPhier SoCs: PH1-sLD3, PH1-LD4, PH1-Pro4,
> and PH1-sLD8.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

[...]

> diff --git a/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts b/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
> new file mode 100644
> index 0000000..2e83363
> --- /dev/null
> +++ b/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
> @@ -0,0 +1,51 @@
> +/*
> + * Device Tree Source for UniPhier PH1-LD4 Reference Board
> + *
> + * Copyright (C) 2015 Socionext Inc.
> + *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */

Please consider licensing .dts/.dtsi files also under another, more liberal 
license, e.g. X11. This would allow easier reuse of these device tree in other 
software projects. See for example 2ef6ef91c54e (ARM: sun4i: a1000: Relicense 
the device tree under GPLv2/X11, 2014-09-02).

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
