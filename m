From: l.stach@pengutronix.de (Lucas Stach)
Date: Tue, 25 Feb 2014 18:47:22 +0100
Subject: [PATCH 0/2] PCI: imx6: MSI support
Message-ID: <1393350444-29784-1-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Those two simple patches add support for MSI to the
i.MX6 PCIe host controller driver.

The first patch should probably go through Shawns tree, while
the second one should go through the PCI tree. I'm only posting
them together to get you the whole picture.

Juergen Beisert (2):
  ARM: dts: imx6: adjust the interrupt list in order to support MSI
  PCI: imx6: add support for MSI

 arch/arm/boot/dts/imx6qdl.dtsi |  3 ++-
 drivers/pci/host/pci-imx6.c    | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

-- 
1.8.5.3
