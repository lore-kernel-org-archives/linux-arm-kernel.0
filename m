From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 19 Aug 2017 15:59:15 +0800
Subject: [GIT PULL 2/4] Allwinner driver changes for 4.14, round 2
Message-ID: <20170819075915.4uae73yviij4lkig@wens.csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are some Allwinner driver changes for 4.14.
There were no driver changes in round 1.

Thanks!
ChenYu

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-drivers-for-4.14

for you to fetch changes up to 5e4fb6429761ebe8f5acb5a761fa57d02a91ac6f:

  drivers: soc: sunxi: add support for A64 and its SRAM C (2017-08-18 14:30:21 +0800)

----------------------------------------------------------------
Allwinner driver changes for 4.14

Usual driver changes:

  - SUNXI_RSB bus driver enabled by default for ARM64

  - Support for SRAM controller and SRAM C block on the A64 added

----------------------------------------------------------------
Icenowy Zheng (4):
      dt-bindings: add binding for Allwinner A64 SRAM controller and SRAM C
      drivers: soc: sunxi: fix error processing on base address when claiming
      drivers: soc: sunxi: add support for remapping func value to reg value
      drivers: soc: sunxi: add support for A64 and its SRAM C

Jagan Teki (1):
      bus: sunxi-rsb: Enable by default for ARM64

 .../devicetree/bindings/sram/sunxi-sram.txt        |  9 +++-
 drivers/bus/Kconfig                                |  2 +-
 drivers/soc/sunxi/sunxi_sram.c                     | 57 ++++++++++++++++++----
 3 files changed, 56 insertions(+), 12 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170819/660f9a84/attachment.sig>
