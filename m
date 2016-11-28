From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 28 Nov 2016 17:12:17 +0530
Subject: [GIT PULL 2/4] DaVinci SoC updates for v4.10 (part 3)
In-Reply-To: <20161128114219.22325-1-nsekhar@ti.com>
References: <20161128114219.22325-1-nsekhar@ti.com>
Message-ID: <20161128114219.22325-3-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7e431af8fa0b9ed9d74378c99514856211cb9db8:

  ARM: davinci: PM: support da8xx DT platforms (2016-11-16 14:45:07 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.10/soc-3

for you to fetch changes up to b5e1438cf98a1c588726b0f861178f9aa5a96caf:

  ARM: davinci: da830-evm: use gpio descriptor for mmc pins (2016-11-28 14:01:17 +0530)

----------------------------------------------------------------
mach-davinci SoC support updates to adjust
USB ohci device name to that used by drivers
and update of various board files to use gpio
descriptor API used by MMC subsystem for card
detect and write-protect detection.

----------------------------------------------------------------
Axel Haslam (4):
      ARM: davinci: da8xx: Fix ohci device name
      ARM: davinci: hawk: use gpio descriptor for mmc pins
      ARM: davinci: da850-evm: use gpio descriptor for mmc pins
      ARM: davinci: da830-evm: use gpio descriptor for mmc pins

 arch/arm/mach-davinci/board-da830-evm.c     | 41 ++++++++--------------------
 arch/arm/mach-davinci/board-da850-evm.c     | 35 +++++++-----------------
 arch/arm/mach-davinci/board-omapl138-hawk.c | 42 ++++++++---------------------
 arch/arm/mach-davinci/da830.c               |  2 +-
 arch/arm/mach-davinci/da850.c               |  2 +-
 arch/arm/mach-davinci/da8xx-dt.c            |  2 +-
 arch/arm/mach-davinci/usb-da8xx.c           |  4 +--
 7 files changed, 37 insertions(+), 91 deletions(-)
