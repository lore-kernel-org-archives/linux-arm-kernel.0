From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Thu, 22 Nov 2012 09:34:57 +0530
Subject: [PATCH 0/2] ARM/ASoC: Davinci: Device Tree Update
Message-ID: <1353557099-21599-1-git-send-email-gururaja.hebbar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>

1. Add pinctrl for McASP Module
2. Add DT support for Davinci machine platform (resend)

Second commit is a resend after re-basing on latest broonie-asoc/for-next
(v3.7-rc6)

Hebbar, Gururaja (2):
  ASoC: davinci-mcasp: Add pinctrl support
  ASoC: Davinci: machine: Add device tree binding

 .../bindings/sound/davinci-evm-audio.txt           |   66 +++++++
 sound/soc/davinci/davinci-evm.c                    |  185 +++++++++++++++++---
 sound/soc/davinci/davinci-mcasp.c                  |    7 +
 3 files changed, 238 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/davinci-evm-audio.txt

-- 
1.7.9.5
