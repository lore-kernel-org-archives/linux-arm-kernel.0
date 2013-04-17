From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Apr 2013 20:05:19 +0100
Subject: [PATCH v11 1/3] ARM: Add base support for ARMv7-M
In-Reply-To: <1366215299-31969-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1366215299-31969-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1366215299-31969-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20130417190519.GC14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 17, 2013 at 06:14:57PM +0200, Uwe Kleine-K?nig wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> This patch adds the base support for the ARMv7-M
> architecture. It consists of the corresponding arch/arm/mm/ files and
> various #ifdef's around the kernel. Exception handling is implemented by
> a subsequent patch.
> 
> [ukleinek: squash in some changes originating from commit
> 
> b5717ba (Cortex-M3: Add support for the Microcontroller Prototyping System)
> 
> from the v2.6.33-arm1 patch stack, port to post 3.6, drop zImage
> support, drop reorganisation of pt_regs, assert CONFIG_V7M doesn't leak
> into installed headers and a few cosmetic changes]

ITYM CONFIG_CPU_V7M.  Apart from that, it looks fine.
