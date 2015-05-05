From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 05 May 2015 12:54:38 +0200
Subject: [PATCH 0/3] Drop more omap3 legacy board-*.c files for v4.2
In-Reply-To: <1430769717-4088-1-git-send-email-tony@atomide.com>
References: <1430769717-4088-1-git-send-email-tony@atomide.com>
Message-ID: <2213391.JZ0TJA9KXB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 May 2015 13:01:54 Tony Lindgren wrote:
> 
> For dropping the remaining omap3 legacy boot support, we still
> have the following board-*.c files:
> 
> BOARD                   REASON NEEDED
> board-ldp.c             Still used in RMKs boot test system
> board-omap3logic.c      Getting a .dts file for v4.2
> board-omap3pandora.c    Got a .dts file for v4.1
> board-rx51-*.c          Needs /proc/atags support for user space
> 
> I'm hoping we can drop those for v4.3 merge window, then keep
> the platform data around for one more merge window in case of
> reverting needed, then drop the platform data too for v4.4
> if no issues needing reverting are found.

Sounds great. Has there been a conclusion about what to do for the
rx51 /proc/atags support?

	Arnd
