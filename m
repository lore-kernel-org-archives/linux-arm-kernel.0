From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 14 Jan 2013 23:02:11 +0800
Subject: [PATCH v3 0/2] Add imx6q-cpufreq driver support
Message-ID: <1358175733-13475-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v2:
 - Fix typo in commit log
 - Put all OPPs in dts and disable 1.2 GHz one for Si revs that do not
   support it in kernel.

Shawn Guo (2):
  cpufreq: add imx6q-cpufreq driver
  ARM: imx: enable imx6q-cpufreq support

 arch/arm/boot/dts/imx6q.dtsi    |   20 ++-
 arch/arm/mach-imx/mach-imx6q.c  |   65 +++++++++
 drivers/cpufreq/Kconfig.arm     |    9 ++
 drivers/cpufreq/Makefile        |    1 +
 drivers/cpufreq/imx6q-cpufreq.c |  296 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 385 insertions(+), 6 deletions(-)
 create mode 100644 drivers/cpufreq/imx6q-cpufreq.c

-- 
1.7.9.5
