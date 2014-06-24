From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Jun 2014 11:19:01 +0100
Subject: [PATCH 0/8] iMX6 SATA configuration
Message-ID: <20140624101901.GL32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Another round of these patches.  I've integrated Shawn's patch to split
the documentation into this series so I can add the DT documentation
on top of it.

 .../devicetree/bindings/ata/ahci-platform.txt      |   6 -
 Documentation/devicetree/bindings/ata/imx-sata.txt |  36 ++++
 arch/arm/boot/dts/imx6q-cubox-i.dts                |   4 +
 drivers/ata/ahci_imx.c                             | 184 ++++++++++++++++++++-
 4 files changed, 216 insertions(+), 14 deletions(-)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
