From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Sat, 29 Sep 2018 16:18:58 +0200
Subject: [GIT PULL] Allwinner drivers changes for 4.20
Message-ID: <20180929141858.zt3z5lsahbqdhy4z@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are our SRAM drivers changes for the next merge window.

Thanks!
Maxime

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-drivers-for-4.20

for you to fetch changes up to 69a8c2452caae22008ee170d3ef66e97e9df391e:

  dt-bindings: sunxi-sram: add binding for Allwinner H6 SRAM C (2018-09-12 22:40:26 +0800)

----------------------------------------------------------------
Allwinner drivers changes for 4.20

The H6 is now supported in our SRAM driver bindings, and we have a small
Makefile change for the SRAM driver to build it without building the
ARCH_SUNXI architecture, especially relevant for the COMPILE_TEST case.

----------------------------------------------------------------
Icenowy Zheng (1):
      dt-bindings: sunxi-sram: add binding for Allwinner H6 SRAM C

Paul Kocialkowski (1):
      drivers: soc: Allow building the sunxi driver without ARCH_SUNXI

 Documentation/devicetree/bindings/sram/sunxi-sram.txt | 4 ++++
 drivers/soc/Makefile                                  | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180929/6f6ce5d7/attachment.sig>
