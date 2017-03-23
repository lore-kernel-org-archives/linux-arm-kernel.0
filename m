From: l.stach@pengutronix.de (Lucas Stach)
Date: Thu, 23 Mar 2017 15:44:16 +0100
Subject: [PATCH 0/2] i.MX6QP GPC fixes
Message-ID: <20170323144418.30977-1-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

those 2 patches implement the necessary workaround for the PU power
domain on the i.MX6QP. Both are on top of Dong Aishengs GPC fixes
series.

I'll submit the DT change to make use of the new compatible when
the GPC driver branch has been merged upstream.

Regards,
Lucas

Lucas Stach (2):
  dt-bindings: imx-gpc: add i.MX6 QuadPlus compatible
  soc/imx: add workaround for i.MX6QP to the GPC PD driver

 .../devicetree/bindings/power/fsl,imx-gpc.txt         |  5 ++++-
 drivers/soc/imx/gpc.c                                 | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

-- 
2.11.0
