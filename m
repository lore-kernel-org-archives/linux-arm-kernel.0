From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 16 Apr 2014 15:03:05 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Defconfig Updates for v3.16
Message-ID: <cover.1397627278.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC defconfig updates for v3.16.


The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig-for-v3.16

for you to fetch changes up to 1d59eb190e3dc575c7bbee4a163c3facd0de2ed9:

  ARM: shmobile: Enable USB [EO]HCI HCD support in shmobile_defconfig (2014-04-14 11:23:55 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Defconfig Updates for v3.16

SH Mobile Multi-Platform
* Enable USB [EO]HCI HCD, VSP1, HIGHMEM, USBHS, I2C_SH_MOBILE,
  EEPROM_AT24 and MSIOF

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: shmobile: multiplatform: Enable MSIOF in defconfig

Magnus Damm (4):
      ARM: shmobile: Include i2c-shmobile.c in shmobile_defconfig
      ARM: shmobile: Include at24.c in shmobile_defconfig
      ARM: shmobile: Enable HIGHMEM in shmobile_defconfig
      ARM: shmobile: Enable VSP1 in shmobile_defconfig

Simon Horman (1):
      ARM: shmobile: Enable USB [EO]HCI HCD support in shmobile_defconfig

Ulrich Hecht (1):
      ARM: shmobile: Enable USBHS gadget support in shmobile_defconfig

 arch/arm/configs/shmobile_defconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
