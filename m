From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 3 Mar 2017 18:26:38 +0100
Subject: [PATCH] ARM: DTS armada: Add support for 2 more mvebu model
In-Reply-To: <1488560855-421-1-git-send-email-ansuelsmth@gmail.com>
References: <1488560855-421-1-git-send-email-ansuelsmth@gmail.com>
Message-ID: <20170303172638.GD1488@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 03, 2017 at 06:07:35PM +0100, Ansuel Smith wrote:
> This patch add support for 2 Linksys router model
> (shelby and rango). With this we now support all
> the mvebu board on the market.
> 
> Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
> Signed-off-by: ?lvaro Fern?ndez Rojas <noltari@gmail.com>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  arch/arm/boot/dts/armada-385-linksys-rango.dts  | 443 ++++++++++++++++++++++++
>  arch/arm/boot/dts/armada-385-linksys-shelby.dts | 115 ++++++
>  2 files changed, 558 insertions(+)
>  create mode 100644 arch/arm/boot/dts/armada-385-linksys-rango.dts
>  create mode 100644 arch/arm/boot/dts/armada-385-linksys-shelby.dts
> 
> diff --git a/arch/arm/boot/dts/armada-385-linksys-rango.dts b/arch/arm/boot/dts/armada-385-linksys-rango.dts
> new file mode 100644
> index 0000000..61f4592
> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-385-linksys-rango.dts
> @@ -0,0 +1,443 @@
> +/*
> + * Device Tree file for the Linksys WRT3200ACM (Rango)
> + *
> + * Copyright (C) 2016 Imre Kaloz <kaloz@openwrt.org>
> + *
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is licensed under the terms of the GNU General Public
> + *     License version 2.  This program is licensed "as is" without
> + *     any warranty of any kind, whether express or implied.
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
> +/dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include "armada-385.dtsi"

Hi Ansuel

Please could you explain why you did not use armada-385-linksys.dtsi

Thanks
	Andrew
