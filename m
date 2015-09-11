From: yvo@apm.com (Y Vo)
Date: Fri, 11 Sep 2015 16:22:10 +0700
Subject: [PATCH 0/2] gpio: xgene: add support to configure GPIO line as input,
 output or external IRQ pin
Message-ID: <1441963332-13329-1-git-send-email-yvo@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch supports to configure GPIO line as input, output or external IRQ pin.

Y Vo (2):
  gpio: xgene: add support to configure GPIO line as input, output or  
      external IRQ pin
  Documentation: gpio: Update description for X-Gene standby GPIO
    controller DTS binding

 .../devicetree/bindings/gpio/gpio-xgene-sb.txt     |   26 +++++++++++----
 drivers/gpio/gpio-xgene-sb.c                       |   33 +++++++++++++++----
 2 files changed, 45 insertions(+), 14 deletions(-)
