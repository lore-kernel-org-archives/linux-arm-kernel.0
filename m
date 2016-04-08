From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Fri, 8 Apr 2016 15:31:49 +0800
Subject: [PATCH v2 0/2] arm64: hisilicon: hip05 fix and update
Message-ID: <1460100711-54144-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hip05:
- Fix its node without msi-cells
- Add nor flash node

Change since v1:
- msi-cells should be #msi-cells

Kefeng Wang (2):
  arm64: dts: hip05: fix its node without msi-cells
  arm64: dts: hip05: Add nor flash support

 arch/arm64/boot/dts/hisilicon/hip05-d02.dts | 34 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/hisilicon/hip05.dtsi    | 10 +++++++++
 2 files changed, 44 insertions(+)

-- 
1.7.12.4
