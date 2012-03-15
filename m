From: tony@atomide.com (Tony Lindgren)
Date: Thu, 15 Mar 2012 10:14:00 -0700
Subject: [PATCH 02/10] ARM: OMAP2+: SmartReflex: move the platform
 specific macros in plat-omap
In-Reply-To: <1331829845-9526-3-git-send-email-j-pihet@ti.com>
References: <1331829845-9526-1-git-send-email-j-pihet@ti.com>
 <1331829845-9526-3-git-send-email-j-pihet@ti.com>
Message-ID: <20120315171359.GA7276@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* jean.pihet at newoldbits.com <jean.pihet@newoldbits.com> [120315 09:47]:
> From: Jean Pihet <j-pihet@ti.com>
> 
> Move the platform specific macros from the smartreflex header file
> (arch/arm/mach-omap2/smartreflex.h) in a new header file in plat-omap
> (arch/arm/plat-omap/include/plat/smartreflex.h).
> 
> This change makes the SmartReflex implementation ready for the move
> to drivers/.

Glad to see this happening!

This would be better located in linux/power/smartreflex.h rather than
plat/smartreflex.h.

Regards,

Tony
