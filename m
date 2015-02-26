From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 26 Feb 2015 21:21:37 +0800
Subject: [PATCH 0/2] cpufreq: hisilicon acpu support
Message-ID: <1424956899-8891-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for hisilicon acpu cpufreq driver, which
has been tested on Linaro's 96board "hikey" with hi6220 SoC.

Leo Yan (2):
  cpufreq: hisilicon: add acpu driver
  dt-bindings: cpufreq: document for hisilicon acpu driver

 .../bindings/cpufreq/cpufreq-hisi-acpu.txt         | 112 +++++++
 drivers/cpufreq/Kconfig.arm                        |   9 +
 drivers/cpufreq/Makefile                           |   1 +
 drivers/cpufreq/hisi-acpu-cpufreq.c                | 324 +++++++++++++++++++++
 4 files changed, 446 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-hisi-acpu.txt
 create mode 100644 drivers/cpufreq/hisi-acpu-cpufreq.c

-- 
1.9.1
