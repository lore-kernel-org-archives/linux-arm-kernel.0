From: david.wu@rock-chips.com (David Wu)
Date: Sat, 30 Jan 2016 19:31:55 +0800
Subject: [PATCH v3 0/2] add pinctrl support for rk3399
In-Reply-To: <1451997055-47655-1-git-send-email-wdc@rock-chips.com>
References: <1451997055-47655-1-git-send-email-wdc@rock-chips.com>
Message-ID: <1454153517-52969-1-git-send-email-david.wu@rock-chips.com>
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
