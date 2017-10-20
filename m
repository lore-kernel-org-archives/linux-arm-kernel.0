From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 20 Oct 2017 09:47:20 +0200
Subject: [GIT PULL] Allwinner core changes for 4.15
Message-ID: <20171020074720.7kut3q3j5bzt6esd@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull the following changes for the next merge window

Thanks!
Maxime

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-core-for-4.15

for you to fetch changes up to 14e25a03682f7ca0464ac7e3f3f10f02d885fed4:

  ARM: sunxi: add support for R40 SoC (2017-09-22 21:57:09 +0200)

----------------------------------------------------------------
Allwinner core changes for 4.15

A bunch of patches for the sunxi documentation and mach-sunxi. The most
notable feature is the introduction of the R40 support.

----------------------------------------------------------------
Icenowy Zheng (3):
      dt-bindings: add compatible string for Allwinner V3s SoC
      ARM: sunxi: fix the core number of V3s in sunxi README
      ARM: sunxi: add support for R40 SoC

 Documentation/arm/sunxi/README                  | 11 +++++++++--
 Documentation/devicetree/bindings/arm/sunxi.txt |  2 ++
 arch/arm/mach-sunxi/sunxi.c                     |  1 +
 3 files changed, 12 insertions(+), 2 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171020/02f668ba/attachment.sig>
