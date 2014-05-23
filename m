From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 23 May 2014 23:05:07 +0200
Subject: [GIT PULL] Allwinner drivers changes for 3.16, take 2
Message-ID: <20140523210507.GA18497@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

Here is the last pull request for the driver additions of the
Allwinner stuff for the 3.16 merge window.

The following changes since commit cd90f0cf4454861a4f87bdfdcf01e8b98cc94869:

  reset: sunxi: allow MFD subdevices probe (2014-05-15 10:31:04 +0200)

are available in the git repository at:

  https://github.com/mripard/linux.git tags/sunxi-drivers-for-3.16-2

for you to fetch changes up to 1be7f5520a3885747174008d2905ae551f74ea78:

  power: reset: Add Allwinner A31 reset code (2014-05-23 10:40:34 +0200)

----------------------------------------------------------------
Allwinner drivers changes for 3.16, take 2

Add reset driver for the A31

----------------------------------------------------------------
Maxime Ripard (1):
      power: reset: Add Allwinner A31 reset code

 drivers/power/reset/Kconfig        |  7 ++++
 drivers/power/reset/Makefile       |  1 +
 drivers/power/reset/sun6i-reboot.c | 85 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)
 create mode 100644 drivers/power/reset/sun6i-reboot.c

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140523/d46ac9ef/attachment.sig>
