From: b38611@freescale.com (Fugang Duan)
Date: Tue, 20 May 2014 14:50:43 +0800
Subject: [PATCH v1 0/2] net: fec: Add fec sleep pinctrl for pin PM state
Message-ID: <1400568645-10214-1-git-send-email-b38611@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The two patches is to add fec sleep pinctrl for pin PM state in imx6sl
evk platform.

Fugang Duan (2):
  ARM: dts: imx6sl: add fec sleep pinctrl for pin PM state
  net: fec: use pinctrl PM helpers

 arch/arm/boot/dts/imx6sl-evk.dts          |   16 +++++++++++++++-
 drivers/net/ethernet/freescale/fec_main.c |   10 ++++++++++
 2 files changed, 25 insertions(+), 1 deletions(-)

-- 
1.7.8
