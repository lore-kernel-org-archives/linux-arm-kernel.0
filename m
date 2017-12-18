From: clg@kaod.org (=?UTF-8?Q?C=c3=a9dric_Le_Goater?=)
Date: Mon, 18 Dec 2017 10:08:47 +0100
Subject: [PATCH v2 11/19] ARM: dts: aspeed: Remove skeleton.dtsi
In-Reply-To: <20171215062443.23059-12-joel@jms.id.au>
References: <20171215062443.23059-1-joel@jms.id.au>
 <20171215062443.23059-12-joel@jms.id.au>
Message-ID: <55ef1f45-31a7-4584-1083-aef7bd68634a@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/15/2017 07:24 AM, Joel Stanley wrote:
> We don't require it for any of the ASPEED systems.

Reviewed-by: C?dric Le Goater <clg@kaod.org>


> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi | 1 -
>  arch/arm/boot/dts/aspeed-g5.dtsi | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index b3580f37f507..2d7ac577d6b5 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include "skeleton.dtsi"
>  #include <dt-bindings/clock/aspeed-clock.h>
>  #include <dt-bindings/gpio/aspeed-gpio.h>
>  
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index 50766f0629f8..030a760696fd 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -1,5 +1,4 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include "skeleton.dtsi"
>  #include <dt-bindings/clock/aspeed-clock.h>
>  #include <dt-bindings/gpio/aspeed-gpio.h>
>  
> 
