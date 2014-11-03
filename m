From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon,  3 Nov 2014 15:54:45 +0100
Subject: [PATCH v2 0/3] staging: drm/imx: parallel-display fixes
Message-ID: <1415026488-25309-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Last version of this series did not apply on 3.18-rc1 as it was based on
3.17-rc. I rebased the series and solved the conflict, there are no other
changes to the series. It is now based on v3.18-rc3.

Best Regards,

Markus


Markus Pargmann (1):
  imx-drm: parallel-display: Fix dpms mode handling

Philipp Zabel (2):
  staging: drm/imx: parallel-display: Add 24-bit BGR support
  imx-drm: parallel-display: Fix drm_panel support

 .../bindings/staging/imx-drm/fsl-imx-drm.txt       |  4 ++--
 drivers/staging/imx-drm/parallel-display.c         | 24 +++++++++++++++++++---
 2 files changed, 23 insertions(+), 5 deletions(-)

-- 
2.1.1
