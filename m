From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 21 Jun 2013 10:57:17 +0200
Subject: [PATCH 0/4] IPU DMFC bandwidth allocation fix and cleanups
Message-ID: <1371805041-9299-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the following patches remove some unused variables, replace some
hard-coded channel numbers with existing descriptive defines, fix
the DMFC bandwidth (or rather: FIFO space) allocation, and update
ipu_page_flip() to immediately set crtc->fb.    

regards
Philipp

---
 drivers/staging/imx-drm/imx-drm-core.c    |  3 ---
 drivers/staging/imx-drm/ipu-v3/ipu-dmfc.c | 22 ++++++++++++++++------
 drivers/staging/imx-drm/ipuv3-crtc.c      |  7 +------
 3 files changed, 17 insertions(+), 15 deletions(-)
