From: fugang.duan@nxp.com (Andy Duan)
Date: Fri, 10 Feb 2017 22:27:42 +0800
Subject: [PATCH v1 0/2] clk: imx7d: correct enet clock CCGR register offset
Message-ID: <1486736864-21908-1-git-send-email-fugang.duan@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha report imx7d enet clock CCGR offset are not correct, the patch is to
fix the issue and remove non-existed enet REF_CLK and PHY_REF_CLK clock gates.

Andy Duan (2):
  clk: imx7d: correct enet clock CCGR register offset
  ARM: dts: imx7d: correct enet ipg and enet_out clock

 arch/arm/boot/dts/imx7d.dtsi            |  4 ++--
 arch/arm/boot/dts/imx7s.dtsi            |  4 ++--
 drivers/clk/imx/clk-imx7d.c             | 11 ++++++-----
 include/dt-bindings/clock/imx7d-clock.h |  4 +++-
 4 files changed, 13 insertions(+), 10 deletions(-)

-- 
1.9.1
