From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Fri, 23 Jan 2015 18:21:29 +0800
Subject: [PATCH v6 0/2] Add Spreadtrum Sharkl64 Platform support
In-Reply-To: <sprd-dt-v6>
References: <sprd-dt-v6>
Message-ID: <1422008491-16452-1-git-send-email-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set split the last version, and addressed the review comments from
last version on serial driver code.

Changes from v5:
	- Added maintenance interrupt for gic
	- Removed reg property from 'soc' and 'apb' nodes

Zhizhou Zhang (2):
  arm64: dts: Add support for Spreadtrum SC9836 SoC in dts and Makefile
  arm64: Add support for Spreadtrum's Sharkl64 Platform in Kconfig and
    defconfig

 arch/arm64/Kconfig                            |    5 ++
 arch/arm64/boot/dts/Makefile                  |    1 +
 arch/arm64/boot/dts/sprd/Makefile             |    5 ++
 arch/arm64/boot/dts/sprd/sc9836-openphone.dts |   49 ++++++++++++++++
 arch/arm64/boot/dts/sprd/sc9836.dtsi          |   74 +++++++++++++++++++++++++
 arch/arm64/boot/dts/sprd/sharkl64.dtsi        |   65 ++++++++++++++++++++++
 arch/arm64/configs/defconfig                  |    1 +
 7 files changed, 200 insertions(+)
 create mode 100644 arch/arm64/boot/dts/sprd/Makefile
 create mode 100644 arch/arm64/boot/dts/sprd/sc9836-openphone.dts
 create mode 100644 arch/arm64/boot/dts/sprd/sc9836.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/sharkl64.dtsi

-- 
1.7.9.5
