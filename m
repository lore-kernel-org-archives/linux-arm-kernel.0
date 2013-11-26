From: tony@atomide.com (Tony Lindgren)
Date: Tue, 26 Nov 2013 15:46:43 -0800
Subject: [PATCH] ARM: Kill CONFIG_MTD_PARTITIONS
In-Reply-To: <17954130.75631385509274999.JavaMail.weblogic@epml11>
References: <17954130.75631385509274999.JavaMail.weblogic@epml11>
Message-ID: <20131126234643.GU26766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Eunbong Song <eunb.song@samsung.com> [131126 15:42]:
> 
> This patch removes CONFIG_MTD_PARTITIONS in config files for ARM.
> Because CONFIG_MTD_PARTITIONS was removed by commit 6a8a98b22b10f1560d5f90aded4a54234b9b2724.

Missing Signed-off-by?

This patch is probably best sent to the arm-soc maintainers so
they can pick it up. For the omap changes:

Acked-by: Tony Lindgren <tony@atomide.com> 
 
