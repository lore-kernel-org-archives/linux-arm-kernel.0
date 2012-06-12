From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 12 Jun 2012 16:06:16 +0200
Subject: [PATCH v2] arm: Add basic support for new Marvell Armada 370 and
 Armada XP SoC
In-Reply-To: <201206121349.27696.arnd@arndb.de>
References: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
 <201206121349.27696.arnd@arndb.de>
Message-ID: <20120612140616.GC17893@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> arch/arm/mach-kirkwood/board-* (DT files)
> 	-> arch/arm/mach-mvebu/

I know of work being done to make orion5x and dove also support DT.
Should we consider some sort of prefix or midfix indicating which SoC
a board file is for? It will not be easy to mentally keep track of
board-ts209.c is an orion5x and board-ts219.c is kirkwood etc.

      Andrew
