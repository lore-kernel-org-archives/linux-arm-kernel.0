From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 27 Feb 2018 13:27:44 +0530
Subject: [GIT PULL 2/3] DaVinci device-tree updates for v4.17
In-Reply-To: <20180227075745.23970-1-nsekhar@ti.com>
References: <20180227075745.23970-1-nsekhar@ti.com>
Message-ID: <20180227075745.23970-2-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.17/dt

for you to fetch changes up to 25c88cb1c05856f365484c6647d8e17bfd7f3363:

  ARM: dts: da850-evm: add chosen and SPI alias (2018-02-26 12:02:24 +0530)

----------------------------------------------------------------
DaVinci DT support enhancements for v4.17

* Lego EV3 gains firmware recovery mode support
* Miscellaneous non-critical clean-up

----------------------------------------------------------------
Adam Ford (1):
      ARM: dts: da850-evm: add chosen and SPI alias

Bartosz Golaszewski (1):
      ARM: dts: da850-lego-ev3: use a correct fallback for at24 compatible

David Lechner (1):
      ARM: dts: da850-lego-ev3: Add node for reboot modes

 arch/arm/boot/dts/da850-evm.dts      |  5 +++++
 arch/arm/boot/dts/da850-lego-ev3.dts | 19 ++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)
