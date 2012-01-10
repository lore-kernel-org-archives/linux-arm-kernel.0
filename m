From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 10 Jan 2012 10:28:25 +0000
Subject: [GIT PULL] picoxcell fix for 3.3
Message-ID: <20120110102825.GB3226@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull this last fix for 3.3 which fixes up some fallout from the 
runtime sched_clock changes and broke compilation for picoxcell.

Thanks,

Jamie

The following changes since commit ef3a0bf5bfadbace156fa2a3b9c753df2de41df2:

  ARM: 7269/1: mach-sa1100: fix sched_clock breakage (2012-01-05 13:23:02 +0000)

are available in the git repository at:
  git://github.com/jamieiles/linux-2.6-ji.git picoxcell-fixes

Jamie Iles (1):
      ARM: picoxcell: fix sched_clock() cleanup fallout

 arch/arm/mach-picoxcell/time.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
