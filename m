From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 26 Jan 2012 18:22:00 +0200
Subject: [PATCH v1 0/3] Add support for LP3
Message-ID: <1327594923-21822-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce support for LP3 (CPU core clockgating) for Tegra20 and Tegra30.

Peter De Schrijver (3):
  ARM: tegra: definitions for flow controller
  ARM: tegra: assembler code for LP3
  ARM: tegra: cpuidle driver for tegra

 arch/arm/mach-tegra/Makefile   |    2 +
 arch/arm/mach-tegra/cpuidle.c  |  107 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/flowctrl.h |   37 ++++++++++++++
 arch/arm/mach-tegra/sleep.S    |   91 ++++++++++++++++++++++++++++++++++
 4 files changed, 237 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/cpuidle.c
 create mode 100644 arch/arm/mach-tegra/flowctrl.h
 create mode 100644 arch/arm/mach-tegra/sleep.S

-- 
1.7.7.rc0.72.g4b5ea.dirty
