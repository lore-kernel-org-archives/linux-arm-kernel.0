From: yvo@apm.com (Y Vo)
Date: Mon, 26 Oct 2015 13:49:32 +0700
Subject: [PATCH v2 0/3] gpio: xgene: add support to configure GPIO line as
 input, output or external IRQ pin
Message-ID: <1445842175-11446-1-git-send-email-yvo@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

V2 Changes:
	- support X-Gene standby GPIO as an interrupt controller.

Y Vo (3):
  gpio: xgene: add support to configure GPIO line as input, output or  
      external IRQ pin
  Documentation: gpio: Update description for X-Gene standby GPIO    
    controller DTS binding
  arm64: dts: Update APM X-Gene standby GPIO controller DTS entries

 .../devicetree/bindings/gpio/gpio-xgene-sb.txt     |   23 ++-
 arch/arm64/boot/dts/apm/apm-storm.dtsi             |   15 +-
 drivers/gpio/gpio-xgene-sb.c                       |  234 +++++++++++++++++---
 3 files changed, 223 insertions(+), 49 deletions(-)
