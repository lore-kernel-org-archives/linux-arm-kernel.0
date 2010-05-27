From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 May 2010 20:45:59 +0100
Subject: [PATCH 1/4] ARM: S3C64XX: Add support for Compact Flash driver
	on SMDK6410
In-Reply-To: <1274948524-2970-2-git-send-email-kgene.kim@samsung.com>
References: <1274948524-2970-1-git-send-email-kgene.kim@samsung.com>
	<1274948524-2970-2-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100527194559.GC25921@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 27, 2010 at 05:22:01PM +0900, Kukjin Kim wrote:
> +#include <mach/map.h>
> +#include <mach/gpio.h>

shouldn't this be linux/gpio.h ?
