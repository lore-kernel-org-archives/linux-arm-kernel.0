From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Tue, 28 Jun 2016 13:51:41 +0800
Subject: [PATCH 0/4] arm64: hisilicon: Hip0x dt/config update
Message-ID: <1467093105-1568-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT update:
1) Hip05
- kill unuesd hip05_hns.dtsi
2) Hip06
- Add SAS/HNS node

CONFIG update:
1) Enable SAS/HNS config


Kefeng Wang (4):
  arm64: dts: hip05: kill hip05_hns.dtsi
  arm64: dts: hip06: Append hns node
  arm64: dts: hip06: Append sas node
  arm64: defconfig: Enable Hisi SAS and HNS

 arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi | 180 -------------
 arch/arm64/boot/dts/hisilicon/hip06-d03.dts  |  28 ++
 arch/arm64/boot/dts/hisilicon/hip06.dtsi     | 365 +++++++++++++++++++++++++++
 arch/arm64/configs/defconfig                 |   5 +-
 4 files changed, 397 insertions(+), 181 deletions(-)
 delete mode 100644 arch/arm64/boot/dts/hisilicon/hip05_hns.dtsi

-- 
1.7.12.4
