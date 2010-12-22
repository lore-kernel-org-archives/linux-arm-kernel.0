From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Dec 2010 17:48:47 +0100
Subject: [PATCH 3/6] ARM Realview PCIX map include file changes
In-Reply-To: <201012221633.20748.arnd@arndb.de>
References: <20101222140305.29725.50845.stgit@e102602-lin.cambridge.arm.com>
	<20101222140409.29725.82642.stgit@e102602-lin.cambridge.arm.com>
	<201012221633.20748.arnd@arndb.de>
Message-ID: <201012221748.47517.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 December 2010 16:33:20 Arnd Bergmann wrote:
> On Wednesday 22 December 2010 15:04:09 Colin Tuckley wrote:
> 
> > #define REALVIEW_PB11MP_PCI_IO_SIZE            0x1000          /* 4 Kb */
> 
> Is the I/O space really just 4 kb? This may easily cause problems,
> because the first 4 kb of I/O space are usually reserved for PCI-ISA
> bridges and the like. At least the public documentation for PB-X
> describes a 64 kb space, which is also what everyone else has.

Nevermind, I misread this -- the definition was getting deleted, not added
and the new one for this is right.

	Arnd
