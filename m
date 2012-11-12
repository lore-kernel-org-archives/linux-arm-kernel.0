From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 12 Nov 2012 16:28:58 +0100
Subject: [PATCH] staging drm/imx: updates
Message-ID: <1352734144-14897-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following contains some assorted updates to the i.MX drm driver
for the next merge window.

Sascha

----------------------------------------------------------------
Michael Olbrich (1):
      staging: drm/imx: Fix YUYV support in i.MX IPUv3 base driver

Philipp Zabel (4):
      staging: drm/imx: Add YVU420 support to i.MX IPUv3 base driver
      staging: drm/imx: silence ipu_crtc_dpms debug message
      staging: drm/imx: Add ipu_cpmem_set_yuv_interleaved()
      staging: drm/imx: Remove 300ms delay after memory reset

Sascha Hauer (1):
      staging: drm/imx: Add pinctrl support to parallel display driver

 drivers/staging/imx-drm/ipu-v3/imx-ipu-v3.h |    1 +
 drivers/staging/imx-drm/ipu-v3/ipu-common.c |   33 +++++++++++++++++++++++----
 drivers/staging/imx-drm/ipuv3-crtc.c        |    2 +-
 drivers/staging/imx-drm/parallel-display.c  |   10 ++++++++
 4 files changed, 41 insertions(+), 5 deletions(-)
