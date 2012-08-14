From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 14 Aug 2012 15:36:13 -0400
Subject: [PATCH 2/2] ARM: kirkwood: DT descriptor for Seagate FreeAgent
 Dockstar
In-Reply-To: <1344177973-6505-2-git-send-email-sebastian.hesselbarth@googlemail.com>
References: <1344177973-6505-1-git-send-email-sebastian.hesselbarth@googlemail.com>
 <1344177973-6505-2-git-send-email-sebastian.hesselbarth@googlemail.com>
Message-ID: <20120814193613.GS22226@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 05, 2012 at 04:46:13PM +0200, Sebastian Hesselbarth wrote:
> This adds the corresponding device tree descriptor for the
> Seagate FreeAgent Dockstar based on Kirkwood DT.
> 
> Please note that this patch requires the mach-kirkwood Makefile.boot typo
> fix to fully apply.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
...
> diff --git a/arch/arm/mach-kirkwood/Makefile.boot b/arch/arm/mach-kirkwood/Makefile.boot
> index a571755..2c2edfb 100644
> --- a/arch/arm/mach-kirkwood/Makefile.boot
> +++ b/arch/arm/mach-kirkwood/Makefile.boot
> @@ -11,3 +11,4 @@ dtb-$(CONFIG_MACH_TS219_DT)	+= kirkwood-qnap-ts219.dtb

This series looks great, but will go in after the above line is fixed.
Can you correct and resubmit so we don't get a conflict down the road?

You can just do a v2 of this patch in-reply-to this one.

thx,

Jason.
