From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu,  4 Apr 2013 19:28:56 -0600
Subject: [GIT PULL 1/3] ARM: bcm2835: device tree updates
Message-ID: <1365125338-6668-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch adds two devices to the BCM2835 SoC device tree: the SPI
controller and the HW random number generator.

The SPI controller isn't actually instantiated in the Raspberry Pi
device tree, since there are no on-board SPI devices; it's up to the
end-user to modify their own device-tree to describe whatever they
have attached.

----------------------------------------------------------------

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-rpi.git bcm2835-for-3.10-dt

for you to fetch changes up to a1bf70828ea0547b4e3d7eaeb63ae3eb2400cb93:

  ARM: bcm2835: add Broadcom BCM2835 RNG to the device tree

----------------------------------------------------------------

Lubomir Rintel (1):
      ARM: bcm2835: add Broadcom BCM2835 RNG to the device tree

Stephen Warren (1):
      ARM: bcm2835: add SPI device to DT

 arch/arm/boot/dts/bcm2835.dtsi |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
