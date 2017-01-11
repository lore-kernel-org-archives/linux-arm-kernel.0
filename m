From: dinguyen@kernel.org (Dinh Nguyen)
Date: Wed, 11 Jan 2017 14:07:16 -0600
Subject: [GIT PULL 1/2] SoCFPGA defconfig updates for v4.11
Message-ID: <1484165237-26640-1-git-send-email-dinguyen@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof:

Please pull in this defconfig update for v4.11.

Thanks,
Dinh

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dinguyen/linux.git tags/socfpga_defconfig_updates_for_v4.11

for you to fetch changes up to 4fdf18242408cc0b32b3a1a06510376bf609fa60:

  ARM: socfpga_defconfig: update defconfig for SoCFPGA (2017-01-03 20:29:08 -0600)

----------------------------------------------------------------
SoCFPGA defconfig updates for v4.11
- enables Marvell PHY support
- enable MTD(I2C EEPROM), and NAND support
- enable SPI, RTC and LED support
- enables OF CONFIGFS to support DTS overlays
- enables more FS options
- enables A10 hwmon support

----------------------------------------------------------------
Dinh Nguyen (1):
      ARM: socfpga_defconfig: update defconfig for SoCFPGA

 arch/arm/configs/socfpga_defconfig | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)
