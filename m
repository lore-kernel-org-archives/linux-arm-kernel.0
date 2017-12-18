From: clg@kaod.org (=?UTF-8?Q?C=c3=a9dric_Le_Goater?=)
Date: Mon, 18 Dec 2017 10:05:08 +0100
Subject: [PATCH v2 12/19] ARM: dts: aspeed: Update license headers
In-Reply-To: <20171215062443.23059-13-joel@jms.id.au>
References: <20171215062443.23059-1-joel@jms.id.au>
 <20171215062443.23059-13-joel@jms.id.au>
Message-ID: <f0ddb533-4b7c-3cf9-ed57-17c8aec05f1a@kaod.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/15/2017 07:24 AM, Joel Stanley wrote:
> In b24413180f56 ("License cleanup: add SPDX GPL-2.0 license identifier
> to files with no license") these files had the GPL-2.0 licence added
> automatically. Update them to be GPL 2.0+ in line with other IBM kernel
> contributions.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>


Reviewed-by: C?dric Le Goater <clg@kaod.org>

> ---
>  arch/arm/boot/dts/aspeed-ast2500-evb.dts      | 2 +-
>  arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts | 2 +-
>  arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts  | 2 +-
>  arch/arm/boot/dts/aspeed-g4.dtsi              | 2 +-
>  arch/arm/boot/dts/aspeed-g5.dtsi              | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/aspeed-ast2500-evb.dts b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
> index 602bc10fdaf4..3e6f38e5d5d0 100644
> --- a/arch/arm/boot/dts/aspeed-ast2500-evb.dts
> +++ b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0+
>  /dts-v1/;
>  
>  #include "aspeed-g5.dtsi"
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
> index c786bc2f2919..a8f0c046e83e 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0+
>  /dts-v1/;
>  
>  #include "aspeed-g4.dtsi"
> diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
> index 8067793129ea..a7a9386f964d 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0+
>  /dts-v1/;
>  
>  #include "aspeed-g5.dtsi"
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index 2d7ac577d6b5..9c175832babc 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0+
>  #include <dt-bindings/clock/aspeed-clock.h>
>  #include <dt-bindings/gpio/aspeed-gpio.h>
>  
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index 030a760696fd..360329eab7c3 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0+
>  #include <dt-bindings/clock/aspeed-clock.h>
>  #include <dt-bindings/gpio/aspeed-gpio.h>
>  
> 
