From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 11 Oct 2015 17:26:42 +0100
Subject: [GIT PULL] Allwinner drivers for 4.4, round 1
Message-ID: <20151011162642.GA11423@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the following tag for the next merge window.

Thanks!
Maxime

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-drivers-for-4.4

for you to fetch changes up to 1071fd12182f877d7809e49545e4c50b2e406afb:

  soc: sunxi: Add driver for Allwinner Reduced Serial Bus (2015-10-07 10:55:19 +0100)

----------------------------------------------------------------
Allwinner drivers changes for 4.4

A new driver for the Reduced Serial Bus used in the newer Allwinner SoCs to
communicate with the PMIC and other devices made by Allwinner (audio codecs
for example)

----------------------------------------------------------------
Chen-Yu Tsai (2):
      soc: sunxi: Add Allwinner Reduced Serial Bus (RSB) controller bindings
      soc: sunxi: Add driver for Allwinner Reduced Serial Bus

 .../devicetree/bindings/soc/sunxi/rsb.txt          |  47 ++
 drivers/soc/sunxi/Kconfig                          |  10 +
 drivers/soc/sunxi/Makefile                         |   1 +
 drivers/soc/sunxi/sunxi_rsb.c                      | 783 +++++++++++++++++++++
 include/linux/soc/sunxi/sunxi_rsb.h                | 105 +++
 5 files changed, 946 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/sunxi/rsb.txt
 create mode 100644 drivers/soc/sunxi/sunxi_rsb.c
 create mode 100644 include/linux/soc/sunxi/sunxi_rsb.h

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151011/7030ef11/attachment.sig>
