From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 4 May 2016 20:35:50 +0200
Subject: [PATCHv3] ARM: dts: sunxi: Add a olinuxino-lime2-emmc
In-Reply-To: <1462367853-29912-1-git-send-email-oliver@schinagl.nl>
References: <1462367853-29912-1-git-send-email-oliver@schinagl.nl>
Message-ID: <20160504183550.GG17159@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 04, 2016 at 03:17:33PM +0200, Olliver Schinagl wrote:
> There are 3 kinds of OLinuXino Lime2 boards.
> One without any on board storage, one with NAND storage and one with
> eMMC storage. This patch adds the eMMC variant of boards.
> 
> eMMC storage is different from a regular SD card in that it is soldered
> on the board and cannot be changed. Additionally, it shares pins with
> the NAND module and with the second SPI port.
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>

As a general comment, having a log of the changes helps a lot,
especially when you roll new versions quiclky.

> ---
>  .../boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts    | 81 ++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
> new file mode 100644
> index 0000000..9680fcb
> --- /dev/null
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2-emmc.dts
> @@ -0,0 +1,81 @@
> + /*
> + * Copyright 2015 - Ultimaker B.V.
> + * Author Olliver Schinagl <oliver@schinagl.nl>
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
> +#include "sun7i-a20-olinuxino-lime2.dts"
> +
> +/ {
> +	model = "Olimex A20-OLinuXino-LIME2-eMMC";

You should have a compatible here too.

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
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160504/d5f52f03/attachment.sig>
