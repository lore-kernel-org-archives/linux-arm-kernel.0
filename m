From: robh@kernel.org (Rob Herring)
Date: Sat, 16 Dec 2017 12:17:33 -0600
Subject: [PATCH v2 02/19] dt-bindings: gpio: Add ASPEED constants
In-Reply-To: <20171215062443.23059-3-joel@jms.id.au>
References: <20171215062443.23059-1-joel@jms.id.au>
 <20171215062443.23059-3-joel@jms.id.au>
Message-ID: <20171216181733.r5kkxqjgyh4maymp@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 15, 2017 at 04:54:26PM +1030, Joel Stanley wrote:
> These are used to by the device tree to map pin numbers to constants
> required by the GPIO bindings.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi       |  1 +
>  arch/arm/boot/dts/aspeed-g5.dtsi       |  1 +
>  include/dt-bindings/gpio/aspeed-gpio.h | 49 ++++++++++++++++++++++++++++++++++
>  3 files changed, 51 insertions(+)
>  create mode 100644 include/dt-bindings/gpio/aspeed-gpio.h
> 
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index 45d815a86d42..100d092e6c07 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include "skeleton.dtsi"
> +#include <dt-bindings/gpio/aspeed-gpio.h>

Don't you need to use the defines? Probably should be a separate patch.

Rob
