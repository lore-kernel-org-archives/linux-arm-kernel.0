From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Mar 2011 10:29:04 +0000
Subject: [PATCH 1/4] ARM i.MX: Move gpio initialization to SoC specific
	files
In-Reply-To: <1299063683-24903-2-git-send-email-s.hauer@pengutronix.de>
References: <1299063683-24903-1-git-send-email-s.hauer@pengutronix.de>
	<1299063683-24903-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20110303102904.GC13179@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 02, 2011 at 12:01:20PM +0100, Sascha Hauer wrote:
> diff --git a/arch/arm/mach-imx/mm-imx1.c b/arch/arm/mach-imx/mm-imx1.c
> index 378c61b..8613e44 100644
> --- a/arch/arm/mach-imx/mm-imx1.c
> +++ b/arch/arm/mach-imx/mm-imx1.c
> @@ -23,6 +23,8 @@
>  
>  #include <mach/common.h>
>  #include <mach/hardware.h>
> +#include <mach/gpio.h>

linux/gpio.h

> diff --git a/arch/arm/mach-imx/mm-imx21.c b/arch/arm/mach-imx/mm-imx21.c
> index b6152c6..6027e35 100644
> --- a/arch/arm/mach-imx/mm-imx21.c
> +++ b/arch/arm/mach-imx/mm-imx21.c
> @@ -24,6 +24,8 @@
>  #include <mach/common.h>
>  #include <asm/pgtable.h>
>  #include <asm/mach/map.h>
> +#include <mach/gpio.h>

linux/gpio.h

> diff --git a/arch/arm/mach-imx/mm-imx25.c b/arch/arm/mach-imx/mm-imx25.c
> index 09dd8d4..02f7b5c 100644
> --- a/arch/arm/mach-imx/mm-imx25.c
> +++ b/arch/arm/mach-imx/mm-imx25.c
> @@ -27,6 +27,8 @@
>  #include <mach/hardware.h>
>  #include <mach/mx25.h>
>  #include <mach/iomux-v3.h>
> +#include <mach/gpio.h>

linux/gpio.h

> diff --git a/arch/arm/mach-imx/mm-imx27.c b/arch/arm/mach-imx/mm-imx27.c
> index bcaa3b6..e172e3e 100644
> --- a/arch/arm/mach-imx/mm-imx27.c
> +++ b/arch/arm/mach-imx/mm-imx27.c
> @@ -24,6 +24,8 @@
>  #include <mach/common.h>
>  #include <asm/pgtable.h>
>  #include <asm/mach/map.h>
> +#include <mach/gpio.h>

linux/gpio.h

> diff --git a/arch/arm/mach-mx3/mm.c b/arch/arm/mach-mx3/mm.c
> index eefd4cf..54d7174 100644
> --- a/arch/arm/mach-mx3/mm.c
> +++ b/arch/arm/mach-mx3/mm.c
> @@ -27,6 +27,8 @@
>  #include <mach/common.h>
>  #include <mach/hardware.h>
>  #include <mach/iomux-v3.h>
> +#include <mach/gpio.h>

linux/gpio.h

> diff --git a/arch/arm/mach-mx5/mm-mx50.c b/arch/arm/mach-mx5/mm-mx50.c
> index 69b3426..b9c363b 100644
> --- a/arch/arm/mach-mx5/mm-mx50.c
> +++ b/arch/arm/mach-mx5/mm-mx50.c
> @@ -26,6 +26,8 @@
>  #include <mach/hardware.h>
>  #include <mach/common.h>
>  #include <mach/iomux-v3.h>
> +#include <mach/gpio.h>

linux/gpio.h
