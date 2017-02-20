From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Mon, 20 Feb 2017 17:14:49 +0800
Subject: [PATCH v2 0/2] add basic SoC support for HiSilicon Hi3516CV300  
Message-ID: <1487582091-24695-1-git-send-email-xuejiancheng@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi3516CV300 is a SoC designed for HD IP camera. It has an integrated ISP and
H.265 video compression encoder. This patch set is mainly used to add basic SoC
support for Hi3516CV300.

Pan Wen (2):
  arm: hisi: add ARCH_MULTI_V5 support
  arm: dts: hisi: add dts files for Hi3516CV300 demo board

 arch/arm/boot/dts/Makefile             |   1 +
 arch/arm/boot/dts/hi3516cv300-demb.dts |  95 +++++++++
 arch/arm/boot/dts/hi3516cv300.dtsi     | 362 +++++++++++++++++++++++++++++++++
 arch/arm/mach-hisi/Kconfig             |  10 +-
 4 files changed, 462 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/boot/dts/hi3516cv300-demb.dts
 create mode 100644 arch/arm/boot/dts/hi3516cv300.dtsi

-- 
1.9.1
