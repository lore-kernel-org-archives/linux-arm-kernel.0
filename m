From: nm@ti.com (Nishanth Menon)
Date: Wed, 4 Dec 2013 18:49:35 -0600
Subject: [PATCH V2 0/2] ARM: OMAP2+/dts: standardize SoC naming
Message-ID: <1386204578-6018-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Originally attempted partially in [1], the missing binding were
reported as part of Rob's report in [2].

So, here is take two of the series, lacking an standard causes issues
that was fixed such as [3]. Ideally, we should never again introduce a
board file without a exact compatible SoC match.

I have stayed a bit away from updating board and SoC dts files yet
to look at the direction we'd like to go here. If we feel things are
good, I would gladly try to clean our mess up.

Nishanth Menon (2):
  Documentation: dt: OMAP: explicitly state SoC compatible strings
  ARM: OMAP2+: board-generic: update SoC compatibility strings

 .../devicetree/bindings/arm/omap/omap.txt          |   53 ++++++++++++++++++++
 arch/arm/mach-omap2/board-generic.c                |    7 +++
 2 files changed, 60 insertions(+)

[1] https://patchwork.kernel.org/patch/2998201/
[2] http://marc.info/?l=linux-arm-kernel&m=138378029113665&w=2
[3] https://patchwork.kernel.org/patch/3279281/

-- 
1.7.9.5
