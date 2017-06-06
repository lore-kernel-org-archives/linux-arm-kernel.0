From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 6 Jun 2017 19:31:03 +0900
Subject: [PATCH 1/2] arm64: dts: uniphier: add support for LD11 Global
 board
In-Reply-To: <1495678755-13218-2-git-send-email-hayashi.kunihiko@socionext.com>
References: <1495678755-13218-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1495678755-13218-2-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <CAK7LNAQPUr2hrB797tbm-u3i-PKFch_GNGmZtrppk-GAx_VTuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-05-25 11:19 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
> Add initial device tree support for LD11 Global board.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  arch/arm64/boot/dts/socionext/Makefile             |   1 +
>  .../boot/dts/socionext/uniphier-ld11-global.dts    | 105 +++++++++++++++++++++
>  2 files changed, 106 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
>
> diff --git a/arch/arm64/boot/dts/socionext/Makefile b/arch/arm64/boot/dts/socionext/Makefile
> index 5538598b302c..8d07ee33e66f 100644
> --- a/arch/arm64/boot/dts/socionext/Makefile
> +++ b/arch/arm64/boot/dts/socionext/Makefile
> @@ -1,4 +1,5 @@
>  dtb-$(CONFIG_ARCH_UNIPHIER) += \
> +       uniphier-ld11-global.dtb \
>         uniphier-ld11-ref.dtb \
>         uniphier-ld20-ref.dtb
>
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
> new file mode 100644
> index 000000000000..754195aa5a1a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
> @@ -0,0 +1,105 @@
> +/*
> + * Device Tree Source for UniPhier LD11 Global Board
> + *
> + * Copyright (C) 2016-2017 Socionext Inc.
> + *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> + *           Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> + *
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
> + */

Can I ask v2?

Please use SPDX License Identifier.

If you see in ML, you will notice Rob is asking
to use SPDX for new DT files.


I switched existing DT files over to it.

https://patchwork.kernel.org/patch/9765437/
https://patchwork.kernel.org/patch/9765435/


-- 
Best Regards
Masahiro Yamada
