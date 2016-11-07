From: john.garry@huawei.com (John Garry)
Date: Tue, 8 Nov 2016 00:44:22 +0800
Subject: [PATCH 0/3] arm64: dts: hisi: hip06 SAS device tree fixes
Message-ID: <1478537065-169286-1-git-send-email-john.garry@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset resolves some hip06 SAS device tree issues.

John Garry (3):
  arm64: dts: hisi: fix hip06 sas am-max-trans quirk
  arm64: dts: hisi: disable sas0 and sas2 for d03
  arm64: dts: hisi: add refclk node to hip06 dts files for SAS

 arch/arm64/boot/dts/hisilicon/hip06-d03.dts |  8 --------
 arch/arm64/boot/dts/hisilicon/hip06.dtsi    | 11 ++++++++++-
 2 files changed, 10 insertions(+), 9 deletions(-)

-- 
1.9.1
