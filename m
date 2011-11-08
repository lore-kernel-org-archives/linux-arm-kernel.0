From: will.deacon@arm.com (Will Deacon)
Date: Tue,  8 Nov 2011 14:34:52 +0000
Subject: [PATCH 0/2] cpu_logical_map updates for newly merged platforms
Message-ID: <1320762894-11824-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It looks like mach-imx and highbank were recently merged and, as such,
still refer to logical CPU numbers when interacting directly with
hardware.

These two patches should address that, but I'm unable to take them for
a spin (all highbank donations welcome :).

Will Deacon (2):
  ARM: mach-imx: convert logical CPU numbers to physical numbers
  ARM: highbank: convert logical CPU numbers to physical numbers

 arch/arm/mach-highbank/highbank.c |    2 ++
 arch/arm/mach-imx/src.c           |    3 +++
 2 files changed, 5 insertions(+), 0 deletions(-)

-- 
1.7.4.1
