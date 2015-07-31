From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 31 Jul 2015 15:36:29 +0200
Subject: [PATCH 0/3] drm: atmel-hlcdc: add support for several SoCs
Message-ID: <1438349792-6398-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series add the appropriate definitions for the at91sam9x5, at91sam9n12 and
sama5d4 SoCs.

Best Regards,

Boris

Boris Brezillon (3):
  drm: atmel-hlcdc: add support for at91sam9x5 SoCs
  drm: atmel-hlcdc: add support for at91sam9n12 SoC
  drm: atmel-hlcdc: add support for sama5d4 SoCs

 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c | 203 +++++++++++++++++++++++++++
 1 file changed, 203 insertions(+)

-- 
1.9.1
