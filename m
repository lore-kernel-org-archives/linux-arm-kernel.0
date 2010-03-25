From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Mar 2010 20:38:45 +0000
Subject: [PATCH 6/7 v2] Add common platform devices for TCC8xxx SoCs
In-Reply-To: <20100325201649.GI2047@bluebox.local>
References: <20100325200427.GC2047@bluebox.local>
	<20100325201649.GI2047@bluebox.local>
Message-ID: <20100325203845.GG24984@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 09:16:50PM +0100, Hans J. Koch wrote:
> +#include <linux/init.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/io.h>

linux/io.h
