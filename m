From: jamie@jamieiles.com (Jamie Iles)
Date: Sun, 18 Dec 2011 11:00:18 +0000
Subject: [GIT PULL] picoxcell features for 3.3
Message-ID: <20111218110018.GD2376@gallagher>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull this single feature change for picoxcell for 3.3 which is 
based on the previous cleanup branch.

Thanks,

Jamie

The following changes since commit a53bfa07369b7c3448a60d29f0fc2e81751ed0b7:

  MAINTAINERS: add maintainer entry for Picochip picoxcell (2011-12-18 10:48:20 +0000)

are available in the git repository at:
  git://github.com/jamieiles/linux-2.6-ji.git picoxcell-devel

Jamie Iles (1):
      ARM: picoxcell: implement watchdog restart

 arch/arm/mach-picoxcell/common.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)
