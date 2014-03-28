From: lho@apm.com (Loc Ho)
Date: Fri, 28 Mar 2014 14:56:35 -0600
Subject: [PATCH 0/3] rtc: Add APM X-Gene SoC RTC driver
Message-ID: <1396040198-13645-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the APM X-Gene SoC RTC driver.

Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
Signed-off-by: Loc Ho <lho@apm.com>
--
Loc Ho (3):
  Documentation: Add documentation for the APM X-Gene SoC RTC DTS
    binding
  rtc: Add APM X-Gene SoC RTC driver
  arm64: Add APM X-Gene SoC RTC DTS entry

 .../devicetree/bindings/rtc/xgene-rtc.txt          |   28 ++
 arch/arm64/boot/dts/apm-storm.dtsi                 |   21 ++
 drivers/rtc/Kconfig                                |    9 +
 drivers/rtc/Makefile                               |    1 +
 drivers/rtc/rtc-xgene.c                            |  278 ++++++++++++++++++++
 5 files changed, 337 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/xgene-rtc.txt
 create mode 100644 drivers/rtc/rtc-xgene.c
