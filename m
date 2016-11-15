From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 15 Nov 2016 22:18:44 +0100
Subject: [GIT PULL] sun4i-drm fixes for 4.9
Message-ID: <20161115211844.73rypzsalmubd6hf@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Please pull the following fixes for the 4.9 cycle.

Thanks!
Maxime

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-drm-fixes-for-4.9

for you to fetch changes up to 4db069a2bf990e278ea57ff615dcaa89b85376bd:

  drm/sun4i: Propagate error to the caller (2016-11-07 16:09:35 +0100)

----------------------------------------------------------------
sun4i-drm fixes for 4.9

A few patches to fix our error handling and our panel / bridge calls.

----------------------------------------------------------------
Christophe JAILLET (2):
      drm/sun4i: Fix error handling
      drm/sun4i: Propagate error to the caller

Jonathan Liu (1):
      drm/sun4i: rgb: Enable panel after controller

Maxime Ripard (1):
      drm/sun4i: rgb: Remove the bridge enable/disable functions

 drivers/gpu/drm/sun4i/sun4i_drv.c |  4 ++--
 drivers/gpu/drm/sun4i/sun4i_rgb.c | 20 ++++++++------------
 2 files changed, 10 insertions(+), 14 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161115/d1cebdf5/attachment.sig>
