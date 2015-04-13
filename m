From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Apr 2015 01:17:11 +0200
Subject: [PATCH v2 0/3] Alpine: configuration changes
In-Reply-To: <55212e04.o5yIiunegJ+wS/Lz%tsahee@annapurnalabs.com>
References: <55212e04.o5yIiunegJ+wS/Lz%tsahee@annapurnalabs.com>
Message-ID: <201504140117.11804.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 05 April 2015, Tsahee Zidenberg wrote:
> This patchset adds configuration changes required for alpine platform.
> Please consider it for v4.1.
> 
> Using this patchset, the alpine dev. board was able to boot a rootfs from SATA,
> using multi_v7_defconfig and "make all" (sorry for the previous alpine_db mistake).
> 
> Patch #1 enables support for generic PCI host for ARCH_ALPINE.
> 
> Patch #2 adds the device-tree entry for the internal-pci bus.
> 
> Patch #3 adds support for alpine and generic-pci to multi_v7_defconfig.
> 

Sorry for missing these earlier. It's really too late for this stuff now,
but I've made an exception since it was out fault that we missed this,
and all three patches seem really trivial.

	Arnd
