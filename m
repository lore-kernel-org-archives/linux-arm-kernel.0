From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Nov 2012 10:41:32 -0800
Subject: [PATCH 3/5] ARM: OMAP: Move plat/omap-serial.h to
 include/linux/platform_data/serial-omap.h
In-Reply-To: <20121121174230.25576.64507.stgit@muffinssi.local>
References: <20121121174201.25576.61961.stgit@muffinssi.local>
 <20121121174230.25576.64507.stgit@muffinssi.local>
Message-ID: <20121121184131.GA18567@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [121121 09:44]:
> We need to move this file to allow ARM multiplatform configurations
> to build for omap2+. This can now be done as this file now only
> contains platform_data.

Russell, this one depends on your commit fd9980c7 (SERIAL: omap:
remove OMAP_UART_SYSC_RESET and OMAP_UART_FIFO_CLR).

Is that commit immutable and OK to merge as a dependency to my
branch?

Regards,

Tony
