From: xuejiancheng@hisilicon.com (Jiancheng Xue)
Date: Wed, 15 Jun 2016 10:19:04 +0800
Subject: [PATCH v11 0/3] ARM: hisi: Add initial support for Hi3519 SOC
Message-ID: <1465957147-32314-1-git-send-email-xuejiancheng@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These three patches are abstracted from the patchset titled
"[RESEND PATCH v10 0/6] ARM: hisi: Add initial support including
clock driver for Hi3519 soc."(https://lkml.org/lkml/2016/3/31/175).
The clock driver part was merged in v4.7-rc1. This patch set
is mainly used to enable Hi3519 basic soc and add dts files.

Jiancheng Xue (3):
  ARM: hisi: add compatible string for Hi3519 soc
  ARM: dt-bindings: add device tree bindings for Hi3519 sysctrl
  ARM: dts: add dts files for Hi3519

 .../bindings/arm/hisilicon/hi3519-sysctrl.txt      |  14 ++
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/hi3519-demb.dts                  |  42 +++++
 arch/arm/boot/dts/hi3519.dtsi                      | 187 +++++++++++++++++++++
 arch/arm/mach-hisi/hisilicon.c                     |  23 +--
 5 files changed, 249 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/hi3519-sysctrl.txt
 create mode 100644 arch/arm/boot/dts/hi3519-demb.dts
 create mode 100644 arch/arm/boot/dts/hi3519.dtsi

-- 
1.9.1
