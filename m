From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 18 Apr 2013 15:03:01 +0200
Subject: [PATCH v4 0/2] video: imxfb DT support
Message-ID: <1366290183-367-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series adds DT support for imxfb. Changes are listed in the notes section
of each patch.

Regards,

Markus


Christian Hemp (1):
      imxfb: Set alpha value of the framebuffer

Markus Pargmann (1):
      video: imxfb: Add DT support

 Documentation/devicetree/bindings/video/fsl,imx-fb.txt |  51 ++++++++++++++++++
 drivers/video/imxfb.c                                  | 229 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------
 include/linux/platform_data/video-imxfb.h              |   3 ++
 3 files changed, 248 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/fsl,imx-fb.txt
