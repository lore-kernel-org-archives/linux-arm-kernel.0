From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Wed, 21 Apr 2010 22:49:07 +0400
Subject: [PATCH 0/2] Couple of SA11x0 cpufreq fixes
Message-ID: <1271875749-2891-1-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Here's couple of simple sa11x0 cpufreq-related fixes:

Dmitry Artamonow (2):
  SA1100: fix wrong CPU type for h3100 and h3600
  SA1100: add processor check to sa1110-cpufreq driver

 arch/arm/mach-sa1100/Kconfig      |    4 ++--
 arch/arm/mach-sa1100/cpu-sa1110.c |    3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)
