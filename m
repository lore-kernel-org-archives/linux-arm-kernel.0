From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 15 Nov 2016 22:21:06 +0100
Subject: [GIT PULL] sun4i-drm changes for 4.10
Message-ID: <20161115212106.r5ek2axak2xqld2r@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Please pull the following changes for the next merge window.

Thanks!
Maxime

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-drm-for-4.10

for you to fetch changes up to 47d7fbb32c57c8d1722a3e9bd21e501e80fd0741:

  drm/sun4i: Add a few formats (2016-11-02 19:37:37 +0100)

----------------------------------------------------------------
sun4i-drm changes for 4.10

Support for the Allwinner A31 SoC display engine using the sun4i-drm
driver.

----------------------------------------------------------------
Chen-Yu Tsai (4):
      drm/sun4i: sun6i-drc: Support DRC on A31 and A31s
      drm/sun4i: tcon: Move SoC specific quirks to a DT matched data structure
      drm/sun4i: Add compatible string for A31/A31s TCON (timing controller)
      drm/sun4i: Add compatible strings for A31/A31s display pipelines

Maxime Ripard (1):
      drm/sun4i: Add a few formats

 .../bindings/display/sunxi/sun4i-drm.txt           | 10 ++++-
 drivers/gpu/drm/sun4i/sun4i_backend.c              | 21 +++++++++++
 drivers/gpu/drm/sun4i/sun4i_drv.c                  |  5 +++
 drivers/gpu/drm/sun4i/sun4i_layer.c                |  6 +++
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 | 43 ++++++++++++++--------
 drivers/gpu/drm/sun4i/sun4i_tcon.h                 | 11 ++++--
 drivers/gpu/drm/sun4i/sun6i_drc.c                  |  2 +
 7 files changed, 78 insertions(+), 20 deletions(-)

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161115/70c09aa6/attachment.sig>
