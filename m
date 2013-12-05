From: robherring2@gmail.com (Rob Herring)
Date: Wed,  4 Dec 2013 18:23:12 -0600
Subject: [PATCH 0/2] Enable Calxeda cpufreq driver on arm64
Message-ID: <1386202994-30784-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This series enables cpufreq subsystem and the highbank-cpufreq driver
for arm64. Nothing more really than sorting kconfig options to allow
the driver to build. There's no reason for the driver to depend on
ARCH_HIGHBANK and I'm trying to avoid adding that (or a new option)
for arm64.

Rob

Rob Herring (2):
  cpufreq: enable ARM drivers on arm64
  cpufreq: highbank: rework the kconfig dependencies for arm64

 arch/arm64/Kconfig          |  8 ++++++++
 drivers/cpufreq/Kconfig     |  2 +-
 drivers/cpufreq/Kconfig.arm | 14 ++++++--------
 3 files changed, 15 insertions(+), 9 deletions(-)

-- 
1.8.3.2
