From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 May 2012 19:06:51 +0000
Subject: [PATCH 6/8] arm: mach-armada: add support for Armada XP board
 with device tree
In-Reply-To: <4FB27AF4.9050604@codethink.co.uk>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201205151532.21143.arnd@arndb.de> <4FB27AF4.9050604@codethink.co.uk>
Message-ID: <201205151906.52162.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 May 2012, Ben Dooks wrote:
> Yes, I can see a not a lot of fun with multiple PCIe busses and the
> need for a single IO space. You'll probably have to reserve a VM
> area for people to use for legacy-IO accesses.

Yes, that is the plan, across all platforms in the long run actually. 

> With PCIe, there should be less old-style IO as PCIe devices are
> encouraged to go 32bit MMIO.

It should work nonetheless.

	arnd
