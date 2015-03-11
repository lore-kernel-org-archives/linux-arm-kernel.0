From: Chunyan.Zhang@spreadtrum.com (=?gb2312?B?Q2h1bnlhbiBaaGFuZyAo1cW0utHeKQ==?=)
Date: Wed, 11 Mar 2015 02:27:08 +0000
Subject: [PATCH v8 0/2] Add Spreadtrum Sharkl64 Platform support
Message-ID: <1426040790-19495-1-git-send-email-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds Spreadtrum's Sharkl64 support in arm64 device tree.

Changes from v7:
	- Added Mark Rutland's Acked-by
	- Rebased v4.0-rc1

Changes from v6:
	- Setted stdout-path with "serial1:115200n8"

Changes from v5:
	- Added maintenance interrupt for gic
	- Removed reg property from 'soc' and 'apb' nodes


Zhizhou Zhang (2):
  arm64: dts: Add support for Spreadtrum SC9836 SoC in dts and Makefile
  arm64: Add support for Spreadtrum's Sharkl64 Platform in Kconfig and
    defconfig

 arch/arm64/Kconfig                            |  5 ++
 arch/arm64/boot/dts/Makefile                  |  1 +
 arch/arm64/boot/dts/sprd/Makefile             |  5 ++
 arch/arm64/boot/dts/sprd/sc9836-openphone.dts | 49 ++++++++++++++++++
 arch/arm64/boot/dts/sprd/sc9836.dtsi          | 74 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/sprd/sharkl64.dtsi        | 65 +++++++++++++++++++++++
 arch/arm64/configs/defconfig                  |  1 +
 7 files changed, 200 insertions(+)
 create mode 100644 arch/arm64/boot/dts/sprd/Makefile
 create mode 100644 arch/arm64/boot/dts/sprd/sc9836-openphone.dts
 create mode 100644 arch/arm64/boot/dts/sprd/sc9836.dtsi
 create mode 100644 arch/arm64/boot/dts/sprd/sharkl64.dtsi

-- 
1.9.1
