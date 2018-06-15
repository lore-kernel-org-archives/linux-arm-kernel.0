From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Fri, 15 Jun 2018 10:16:47 +0800
Subject: [PATCH v3 0/4] clk: rockchip: support clock controller for px30 SoC
Message-ID: <1529029011-15021-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change in V3:
[PATCH v3 1/4]: Correct description
[PATCH v3 2/4]: Use an SPDX tag instead.
[PATCH v3 3/4]: Use an SPDX tag instead,
		parent_rate might overflow and fix it.
		fix up the checkpatch warning.
		add more CMPOSITE_xxx_HALFdiv.

Change in V2:
[PATCH v2 2/4]: modify the Author name
[PATCH v2 3/4]: provide a bit more explanation for commit message

Elaine Zhang (4):
  dt-bindings: add bindings for px30 clock controller
  clk: rockchip: add dt-binding header for px30
  clk: rockchip: add support for half divider
  clk: rockchip: add clock controller for px30

 .../bindings/clock/rockchip,px30-cru.txt           |   66 ++
 drivers/clk/rockchip/Makefile                      |    2 +
 drivers/clk/rockchip/clk-half-divider.c            |  231 +++++
 drivers/clk/rockchip/clk-px30.c                    | 1080 ++++++++++++++++++++
 drivers/clk/rockchip/clk.c                         |   10 +
 drivers/clk/rockchip/clk.h                         |  126 ++-
 include/dt-bindings/clock/px30-cru.h               |  389 +++++++
 7 files changed, 1903 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,px30-cru.txt
 create mode 100644 drivers/clk/rockchip/clk-half-divider.c
 create mode 100644 drivers/clk/rockchip/clk-px30.c
 create mode 100644 include/dt-bindings/clock/px30-cru.h

-- 
1.9.1
