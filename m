From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 27 Mar 2013 14:01:29 +0100
Subject: [PATCH v2 0/5] ARM: imx cpufreq-cpu0
Message-ID: <1364389294-1997-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series adds imx cpufreq-cpu0 support by adding cpufreq-cpu0
platform devices in DT init code of imx27 and imx5.

It also removes the old imx-cpufreq driver.

Regards,

Markus

Changes in v2:
- Remove old imx-cpufreq driver
- Add cpufreq-cpu0 platform devices as required for the latest
  cpufreq-cpu0 driver.
