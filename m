From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 5 Jul 2016 21:59:16 +0200
Subject: [GIT PULL] Allwinner DRM fixes for 4.7, take 2
Message-ID: <20160705195916.GA18944@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Please pull the following fixes for the 4.7 merge window.

Thanks!
Maxime

The following changes since commit 13fef095bde04228316046f997eb963285d8532e:

  drm: sun4i: do cleanup if RGB output init fails (2016-05-30 08:28:33 +0200)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-drm-fixes-for-4.7-2

for you to fetch changes up to 3b8e64f6f8e2d437b15572f445b1932a45f9be6a:

  gpu: drm: sun4i_drv: add missing of_node_put after calling of_parse_phandle (2016-07-05 09:20:29 +0200)

----------------------------------------------------------------
Allwinner DRM driver fixes for 4.7, take 2

A new set of fixes for the sun4i driver, mostly related to vblank handling,
and a minor fix to release a reference on the device tree nodes we're
parsing in the probe logic.

----------------------------------------------------------------
Maxime Ripard (2):
      drm/sun4i: Report proper vblank
      drm/sun4i: Send vblank event when the CRTC is disabled

Peter Chen (1):
      gpu: drm: sun4i_drv: add missing of_node_put after calling of_parse_phandle

 drivers/gpu/drm/sun4i/sun4i_crtc.c | 8 ++++++++
 drivers/gpu/drm/sun4i/sun4i_drv.c  | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160705/b9eb6ad5/attachment.sig>
