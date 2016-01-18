From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Jan 2016 20:38:27 +0100
Subject: [linux-sunxi][PATCH v3 1/5] ARM: dts: sunxi: Add
 sunxi-itead-core-common.dtsi
In-Reply-To: <1452766555-16409-2-git-send-email-codekipper@gmail.com>
References: <1452766555-16409-1-git-send-email-codekipper@gmail.com>
 <1452766555-16409-2-git-send-email-codekipper@gmail.com>
Message-ID: <20160118193827.GQ4581@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 14, 2016 at 11:15:51AM +0100, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> Itead have a core module board that can be populated with either
> an Allwinner A10 or A20 SoC. This patch creates a common dtsi
> which these boards can use.
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  arch/arm/boot/dts/sunxi-itead-core-common.dtsi | 99 ++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sunxi-itead-core-common.dtsi
> 
> diff --git a/arch/arm/boot/dts/sunxi-itead-core-common.dtsi b/arch/arm/boot/dts/sunxi-itead-core-common.dtsi
> new file mode 100644
> index 0000000..0074f7b
> --- /dev/null
> +++ b/arch/arm/boot/dts/sunxi-itead-core-common.dtsi
> @@ -0,0 +1,99 @@
> +/*
> + * Copyright 2015 - Marcus Cooper <codekipper@gmail.com>

Didn't you take that code from the other itead board?

It seems wrong to remove the original author from the copyright list.

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
> +
> +#include "sunxi-common-regulators.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/pinctrl/sun4i-a10.h>

You're not using any of these headers.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160118/bb264095/attachment.sig>
