From: linux-kernel-dev@beckhoff.com (linux-kernel-dev at beckhoff.com)
Date: Thu, 13 Jul 2017 13:04:11 +0200
Subject: [PATCH v2 0/2] Add CX9020 device tree
In-Reply-To: <20170712090408.12212-1-linux-kernel-dev@beckhoff.com>
References: <20170712090408.12212-1-linux-kernel-dev@beckhoff.com>
Message-ID: <20170713110413.12721-1-linux-kernel-dev@beckhoff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrick Bruenn <p.bruenn@beckhoff.com>

Add device tree for Beckhoff CX9020 Embedded PC.

The CX9020 differs from i.MX53 Quick Start Board by:
- use uart2 instead of uart1
- DVI-D connector instead of VGA
- no audio
- CCAT FPGA connected to emi
- enable rtc

Patrick Bruenn (2):
  ARM: dts: imx: add CX9020 Embedded PC device tree
  drm/panel: simple: Add support for ddc-only panel

 arch/arm/boot/dts/Makefile           |   1 +
 arch/arm/boot/dts/imx53-cx9020.dts   | 370 +++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/panel/panel-simple.c |   6 +
 3 files changed, 377 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx53-cx9020.dts

-- 
2.11.0
