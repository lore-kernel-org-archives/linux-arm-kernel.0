From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 21 Jun 2013 10:27:37 +0200
Subject: [PATCH 0/2] i.MX53 IPU + TVE patches
Message-ID: <1371803259-18369-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

converting the IPU IRQ handling to use irq_domain_add_linear is listed in
drivers/staging/imx-drm/TODO as one of the tasks to be done before the IPU
driver can be moved out of staging. These patches fix the number IPU_NUM_IRQS
and add a linear irq domain.

regards
Philipp

---
 drivers/staging/imx-drm/TODO                |  1 -
 drivers/staging/imx-drm/ipu-v3/ipu-common.c | 66 +++++++++++++++++++----------
 drivers/staging/imx-drm/ipu-v3/ipu-prv.h    |  4 +-
 3 files changed, 45 insertions(+), 26 deletions(-)
