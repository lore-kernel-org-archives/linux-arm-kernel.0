From: ayaka@soulik.info (Randy Li)
Date: Mon, 22 Aug 2016 22:18:07 +0800
Subject: [PATCH 0/2 v2] Add a new board TOPEET iTOP for exynos 4412
In-Reply-To: <4767fc2a-95b7-ee0d-f51a-7a5d6ca89d8f@samsung.com>
References: <4767fc2a-95b7-ee0d-f51a-7a5d6ca89d8f@samsung.com>
Message-ID: <1471875489-11428-1-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
 - v2:
   - remove rtc node
     the clock source driver is not done yet.
   - add exynos-bus
   - fix the MFC

Randy Li (2):
  ARM: dts: Add TOPEET itop core board SCP package version
  ARM: dts: add TOPEET itop elite based board

 .../bindings/arm/samsung/samsung-boards.txt        |   3 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/exynos4412-itop-elite.dts        | 147 +++++++
 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi    | 472 +++++++++++++++++++++
 4 files changed, 623 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos4412-itop-elite.dts
 create mode 100644 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi

-- 
2.7.4
