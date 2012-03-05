From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Mar 2012 10:41:42 -0800
Subject: [PATCH] ARM: OMAP4: Add support for Variscite OMAP4460
 System-On-Module
In-Reply-To: <1326898096-4899-1-git-send-email-uri.y@variscite.com>
References: <1326898096-4899-1-git-send-email-uri.y@variscite.com>
Message-ID: <20120305184142.GI12083@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Uri Yosef <uri.y@variscite.com> [120118 06:13]:
> From: Uri Yosef <uri@embedox.com>
> 
> Add support for Variscite OMAP4460 System-On-Module and development kit board.
> Working: LCD, HDMI, USB, UART, Ethernet.

For reference, we're trying to remove board-*.c files by
changing over to device tree. So new board-*.c files will
be merged. You might want to look at booting your board
using board-generic.c and a related .dts file.

While this transition is happening, I can carry some
board-*.c files in the testing-board branch until devices
start working sufficiently for board-generic.c to be
usable.

Regards,

Tony
