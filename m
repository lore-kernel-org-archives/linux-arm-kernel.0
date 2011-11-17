From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Fri, 18 Nov 2011 00:15:36 +0200
Subject: [PATCH] MTD: nand: Making  MTD_NAND_OMAP2 depend on ARCH_OMAP2PLUS
In-Reply-To: <1321420680-4677-1-git-send-email-shubhrajyoti@ti.com>
References: <1321420680-4677-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1321568138.2272.30.camel@koala>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-11-16 at 10:48 +0530, Shubhrajyoti D wrote:
> Making  MTD_NAND_OMAP2 depend on ARCH_OMAP2PLUS instead of
> oring with ARCH2/3/4.
> 
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

Pushed to l2-mtd-2.6, thanks!

Artem.
