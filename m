From: david.wu@rock-chips.com (David Wu)
Date: Sat, 30 Jan 2016 20:20:11 +0800
Subject: [PATCH v4 0/2] add pinctrl support for rk3399
Message-ID: <1454156413-56148-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Test on rk3399 fpga-board

David Wu (2):
  pinctrl: rockchip: add support for the rk3399
  dt-bindings: rockchip-pinctrl: Support the RK3399 SoCs compatible

 .../bindings/pinctrl/rockchip,pinctrl.txt          |   1 +
 drivers/pinctrl/pinctrl-rockchip.c                 | 372 ++++++++++++++++++++-
 2 files changed, 359 insertions(+), 14 deletions(-)

-- 
1.9.1
