From: joel@jms.id.au (Joel Stanley)
Date: Wed,  3 Oct 2018 15:31:53 +0200
Subject: [PATCH 0/2] rtc: Add ASPEED RTC
Message-ID: <20181003133155.27494-1-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the ASPEED RTC hardware.

Joel Stanley (2):
  rtc: Add ASPEED RTC driver
  dt-bindings: rtc: Add ASPEED description

 .../devicetree/bindings/rtc/rtc-aspeed.txt    |  18 +++
 drivers/rtc/Kconfig                           |  10 ++
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-aspeed.c                      | 142 ++++++++++++++++++
 4 files changed, 171 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-aspeed.txt
 create mode 100644 drivers/rtc/rtc-aspeed.c

-- 
2.17.1
