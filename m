From: caesar.wang@rock-chips.com (Caesar Wang)
Date: Wed, 27 Aug 2014 07:41:41 +0800
Subject: [PATCH v2 0/2] Rockchip soc theamal driver
Message-ID: <1409096503-7081-1-git-send-email-caesar.wang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for the thermal Found on Rockhip RK32 SoCs.
Tested on RK3288 SDK board.

Changes in v2:
	* address comments from Heiko Stubner:
	- fix dt-bindings in rockchip-thermal.txt
	- remove Author mark 
	- rename TSADC_XXX->TSADC_XXX,it eill ready to merge compatible other SoCs.
	- fix a identation
	- remove clk_set_rate(),it's no necessary. 
	- fix the SIMPLE_DEV_PM_OPS() function  style.

Caesar Wang (2):
  thermal: rockchip: add driver for thermal
  dt-bindings: document Rockchip thermal

 .../bindings/thermal/rockchip-thermal.txt          |   20 +
 drivers/thermal/Kconfig                            |    9 +
 drivers/thermal/Makefile                           |    1 +
 drivers/thermal/rockchip_thermal.c                 |  642 ++++++++++++++++++++
 4 files changed, 672 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
 create mode 100644 drivers/thermal/rockchip_thermal.c

-- 
1.7.9.5
