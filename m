From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 May 2010 20:47:14 +0100
Subject: [PATCH 3/4] ARM: S5PC100: Add support for Compact Flash driver
	on SMDKC100
In-Reply-To: <1274948524-2970-4-git-send-email-kgene.kim@samsung.com>
References: <1274948524-2970-1-git-send-email-kgene.kim@samsung.com>
	<1274948524-2970-4-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100527194714.GE25921@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 27, 2010 at 05:22:03PM +0900, Kukjin Kim wrote:
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <linux/io.h>
> +
> +#include <mach/gpio.h>

linux/gpio.h ?
