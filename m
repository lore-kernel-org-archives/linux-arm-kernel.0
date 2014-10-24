From: m-karicheri2@ti.com (Murali Karicheri)
Date: Fri, 24 Oct 2014 13:51:31 -0400
Subject: [PATCH 0/4] Enable PCI controller for Keystone SoCs
Message-ID: <1414173095-32511-1-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that Keystone PCI driver is merged to v3.18, this patch series
add build options and DTS bindings to enable the driver for Keystone SoCs.

CC : Santosh Shilimkar <santosh.shilimkar@gmail.com>
CC : Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC : Rob Herring <robh+dt@kernel.org>
CC : Pawel Moll <pawel.moll@arm.com>
CC : Mark Rutland <mark.rutland@arm.com>
CC : Ian Campbell <ijc+devicetree@hellion.org.uk>
CC : Kumar Gala <galak@codeaurora.org>
CC : Russell King <linux@arm.linux.org.uk>
CC : devicetree at vger.kernel.org

Murali Karicheri (4):
  ARM: keystone: add pcie related options
  ARM: keystone: defconfig: add options to enable PCI controller
  ARM: keystone: dts: add DT bindings for PCI controller for port 0
  ARM: keystone: dts: add DT bindings for PCI controller for port 1

 arch/arm/boot/dts/k2e.dtsi          |   45 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/keystone.dtsi     |   45 +++++++++++++++++++++++++++++++++++
 arch/arm/configs/keystone_defconfig |    3 +++
 arch/arm/mach-keystone/Kconfig      |    2 ++
 4 files changed, 95 insertions(+)

-- 
1.7.9.5
