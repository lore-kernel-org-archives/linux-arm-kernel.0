From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Oct 2017 10:08:48 +0200
Subject: [GIT PULL] Allwinner arm64 DT changes for 4.15
Message-ID: <20171020080848.fpd3sbotbe3llgpv@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please pull the following changes for the next merge window.

Thanks!
Maxime

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-dt64-for-4.15

for you to fetch changes up to d25d41827fee2b489518eee99ef156b005c0c01e:

  arm: allwinner: Correct unit name in devicetree binding example (2017-09-28 18:23:50 +0200)

----------------------------------------------------------------
Allwinner arm64 DT changes for 4.15

Most notable changes:
  - SPI and DMA support on the a64
  - New boards: NanoPi NEO Plus2

----------------------------------------------------------------
Antony Antony (1):
      arm64: allwinner: h5: add NanoPi NEO Plus2 DT support

Corentin LABBE (2):
      arm64: allwinner: a64: Fix simple-bus unit address format error
      arm64: allwinner: a64: Fix node with unit name and no reg property

Stefan Br?ns (4):
      arm64: allwinner: a64: add SPI nodes
      arm64: allwinner: a64: Add device node for DMA controller
      arm64: allwinner: a64: add dma controller references to spi nodes
      arm: allwinner: Correct unit name in devicetree binding example

 .../devicetree/bindings/dma/sun6i-dma.txt          |   2 +-
 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi      |  76 ++++++--
 .../dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts   | 193 +++++++++++++++++++++
 4 files changed, 261 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-nanopi-neo-plus2.dts

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171020/b42bf09a/attachment.sig>
