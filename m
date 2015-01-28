From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Wed, 28 Jan 2015 19:08:42 +0800
Subject: [PATCH v10 0/2] Add Spreadtrum SoC bindings and serial driver support
In-Reply-To: <sc9836-serial-v10>
References: <sc9836-serial-v10>
Message-ID: <1422443324-25082-1-git-send-email-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes from v9:
	- Added SUPPORT_SYSRQ definition for sprd serial

Changes from v8:
	- Removed a few unuseful code lines.

Chunyan Zhang (2):
  Documentation: DT: Add bindings for Spreadtrum SoC Platform
  tty/serial: Add Spreadtrum sc9836-uart driver support

 Documentation/devicetree/bindings/arm/sprd.txt     |   11 +
 .../devicetree/bindings/serial/sprd-uart.txt       |    7 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/tty/serial/Kconfig                         |   18 +
 drivers/tty/serial/Makefile                        |    1 +
 drivers/tty/serial/sprd_serial.c                   |  793 ++++++++++++++++++++
 include/uapi/linux/serial_core.h                   |    3 +
 7 files changed, 834 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/sprd.txt
 create mode 100644 Documentation/devicetree/bindings/serial/sprd-uart.txt
 create mode 100644 drivers/tty/serial/sprd_serial.c

-- 
1.7.9.5
