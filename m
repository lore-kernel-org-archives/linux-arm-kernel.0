From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 29 Jan 2016 16:39:00 +0800
Subject: [PATCH 0/6] arm64: hip05: update
Message-ID: <1454056746-5048-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable more feature in hip05 d02 board.

Kefeng Wang (6):
  arm64: dts: hip05: Add L2 cache topology
  arm64: dts: hip05: Use Cortex specific device node for pmu
  arm64: dts: hip05: Append all gicv3 ITS entries
  arm64: dts: hip05: Append gpio nodes
  arm64: dts: hip05: Append power button node for D02 board
  arm64: defconfig: Enable DesignWare APB GPIO controller

 arch/arm64/boot/dts/hisilicon/hip05-d02.dts | 18 ++++++
 arch/arm64/boot/dts/hisilicon/hip05.dtsi    | 92 ++++++++++++++++++++++++++++-
 arch/arm64/configs/defconfig                |  1 +
 3 files changed, 109 insertions(+), 2 deletions(-)

-- 
2.6.0.GIT
