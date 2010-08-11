From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Aug 2010 08:27:13 +0100
Subject: [PATCH v3] OpenRD: Enable SD/UART selection for serial port 1
In-Reply-To: <1281504062-3314-1-git-send-email-tanmay.upadhyay@einfochips.com>
References: <yes>
	<1281504062-3314-1-git-send-email-tanmay.upadhyay@einfochips.com>
Message-ID: <20100811072713.GB21511@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 11, 2010 at 10:51:02AM +0530, Tanmay Upadhyay wrote:
> diff --git a/arch/arm/mach-kirkwood/openrd-setup.c b/arch/arm/mach-kirkwood/openrd-setup.c
> index fd06be6..46378c0 100644
> --- a/arch/arm/mach-kirkwood/openrd-setup.c
> +++ b/arch/arm/mach-kirkwood/openrd-setup.c
> @@ -19,6 +19,7 @@
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
>  #include <mach/kirkwood.h>
> +#include <mach/gpio.h>

linux/gpio.h
