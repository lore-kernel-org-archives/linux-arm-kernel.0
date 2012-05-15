From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 15 May 2012 16:29:24 +0200
Subject: [PATCH 6/8] arm: mach-armada: add support for Armada XP board
 with device tree
In-Reply-To: <201205151425.30706.arnd@arndb.de>
References: <1337072084-21967-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <4FB25FE9.3060209@codethink.co.uk> <20120515161655.504f1403@skate>
 <201205151425.30706.arnd@arndb.de>
Message-ID: <20120515162924.5638630b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le Tue, 15 May 2012 14:25:30 +0000,
Arnd Bergmann <arnd@arndb.de> a ?crit :

> I'm pretty sure we can use ioremap for new PCI implementations now.
> Also, you can scan the device tree in map_io() if necesary, to see
> which PCIe ports are enabled.

Great. We'll work on that before submitting the PCIe bits.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
