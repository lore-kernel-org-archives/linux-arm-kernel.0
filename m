From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Feb 2013 22:04:19 +0000
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <20130206194222.27db0d90@skate>
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
 <51129F6B.1050709@wwwdotorg.org> <20130206194222.27db0d90@skate>
Message-ID: <201302062204.19383.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 February 2013, Thomas Petazzoni wrote:
> Can't we simply agree on having a first implementation that does the
> simple thing, like the existing PCIe implementation for earlier Marvell
> SoC families, and improve that if it happens to be needed, depending on
> user feedback?

Makes sense. I just looked up the kirkwood source to verify that the
window is set up to map PCI IO address 0x10000-0x1ffff for the second
bus to KIRKWOOD_PCIE1_IO_PHYS_BASE, which is mapped to logical port
number 0x10000-0x1ffff (identity mapping).

	Arnd
