From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Sat, 17 Nov 2018 10:12:03 -0800
Subject: [PATCH 0/3] GPCv2 support for i.MX8MQ
Message-ID: <20181117181206.10267-1-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Everyone:

This series contains changes I made to add support for i.MX8MQ to
GPCv2 driver in order to enable support of PCIE IP block on i.MX8MQ
SoCs (full tree can be found at [github-v0]). This series is _very_
preliminary and by no means is ready for inclusion (it also has some
unmet dependencies).  However is should be in OK enough shape to get
some early feedback on, which is the intent of this submission.

All other feedback is appreciated as well!

Thank you,
Andrey Smirnov

[github-v0] https://github.com/ndreys/linux/commits/imx8mq-pcie-v0

Andrey Smirnov (3):
  soc: imx: gpcv2: Remove static qualifier from domain_data
  soc: imx: gpcv2: Make regmap access table variant specific.
  soc: imx: gpcv2: Add support for i.MX8MQ

 drivers/soc/imx/Kconfig |   4 +-
 drivers/soc/imx/gpcv2.c | 238 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 219 insertions(+), 23 deletions(-)

-- 
2.19.1
