From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Jun 2012 10:54:15 +0000
Subject: [PATCH 5/9] ARM: kirkwood: use devicetree for orion-spi
In-Reply-To: <20120614093135.GE4799@lunn.ch>
References: <1339324322-29388-6-git-send-email-andrew@lunn.ch>
 <201206132110.31011.arnd@arndb.de> <20120614093135.GE4799@lunn.ch>
Message-ID: <201206141054.16223.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 June 2012, Andrew Lunn wrote:
> We either have auxdata and clean clock code, or no auxdata and messy
> clock code with lots of aliases.
> 
> The auxdata is also not limited to the name of the clocks. It allows
> me to diff the kernel log for a DT boot and a none DT boot of the same
> box and see they are identical. I've found a few typo's that way, and
> not been hindered by noise of the devices changing name is useful.
> 
> Once we have the clock tree described in DT, then i think it makes
> sense to remove these auxdata entries.
> 

Ok, fair enough.

	Arnd
