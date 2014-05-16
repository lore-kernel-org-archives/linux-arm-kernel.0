From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 16 May 2014 14:40:33 +0200
Subject: [GIT PULL] Allwinner drivers for 3.16
Message-ID: <20140516124033.GA23014@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Please pull the following pull-request for 3.16

Thanks,
Maxime

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  https://github.com/mripard/linux.git sunxi/drivers-for-3.16

for you to fetch changes up to cd90f0cf4454861a4f87bdfdcf01e8b98cc94869:

  reset: sunxi: allow MFD subdevices probe (2014-05-15 10:31:04 +0200)

----------------------------------------------------------------
Allwinner drivers changes for 3.16

Reset drivers for the A31, that have been merged with reset maintainer's Acked-by.

----------------------------------------------------------------
Boris BREZILLON (2):
      reset: sunxi: document sunxi's reset controllers bindings
      reset: sunxi: allow MFD subdevices probe

 .../bindings/reset/allwinner,sunxi-clock-reset.txt  | 21 +++++++++++++++++++++
 drivers/reset/reset-sunxi.c                         | 21 ++++++++++++++++++---
 2 files changed, 39 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/allwinner,sunxi-clock-reset.txt

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140516/b03f2b19/attachment.sig>
