From: code@mmayer.net (Markus Mayer)
Date: Wed, 18 Apr 2018 08:56:41 -0700
Subject: [PATCH 0/2] brcmstb-avs-cpufreq changes
Message-ID: <20180418155643.36464-1-code@mmayer.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Mayer <mmayer@broadcom.com>

These changes are based on v4.17-rc1. The two patches are unrelated.

Patch 1/2 removes unused code that was only useful during driver
development and that has been disabled by default for a long time.

Patch 2/2 allows the driver to detect if the system supports SCMI cpufreq

Jim Quinlan (1):
  cpufreq: brcmstb-avs-cpufreq: prefer SCMI cpufreq if supported

Markus Mayer (1):
  cpufreq: brcmstb-avs-cpufreq: remove development debug support

 drivers/cpufreq/Kconfig.arm           |  10 -
 drivers/cpufreq/brcmstb-avs-cpufreq.c | 339 ++--------------------------------
 2 files changed, 17 insertions(+), 332 deletions(-)

-- 
2.7.4
