From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 1 Jun 2011 10:43:14 +0100
Subject: [PATCH 0/5] S3C64xx updates
Message-ID: <20110601094313.GA23122@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set of patches has all been previously posted prior to the 3.0-rc1
release, some of them are really quite old now.  Kukjin, I seem to
recall you said were OK with several of these patches already?

Ben Dooks (2):
      ARM: SAMSUNG: Add support for pre-sleep/post-restore gpio control
      ARM: S3C64XX: Ensure VIC based IRQs can be resumed from

Mark Brown (3):
      CPUFREQ/S3C64xx: Move S3C64xx CPUfreq driver into drivers/cpufreq
      ARM: S3C6410: Support 800MHz operation in cpufreq
      ARM: S3C6410: Add some lower frequencies for 800MHz base clock operation
