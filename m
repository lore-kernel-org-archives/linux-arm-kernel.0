From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue,  5 Feb 2013 21:54:53 +0100
Subject: [PATCH 0/2] Add SPI flash for Aramda 370 and XP dev board
Message-ID: <1360097695-32663-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Following the Ezequiel's patches this patch set add support for SPI
data Flash for two other development board from Marvell.

This pacthes depend on the SPI serie of Ezequiel [1], and also on the
selection of CONFIG_MTD_M25P80=y in the config file.

[1] http://thread.gmane.org/gmane.linux.kernel.spi.devel/12568

Gregory CLEMENT (2):
  arm: mvebu: Add SPI flash on Armada XP-DB board
  arm: mvebu: Add SPI flash on Armada 370 DB board

 arch/arm/boot/dts/armada-370-db.dts |   11 +++++++++++
 arch/arm/boot/dts/armada-xp-db.dts  |   12 ++++++++++++
 2 files changed, 23 insertions(+)

-- 
1.7.9.5
