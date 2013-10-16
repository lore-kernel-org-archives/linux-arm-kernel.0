From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 16 Oct 2013 14:36:32 +0100
Subject: [PATCH 0/2] Versatile Express config update for 3.13
Message-ID: <1381930594-1701-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greetings,

This micro-series updates the Versatile Express defconfig in two stages:

1. Makes the defconfig-ed kernels actually work on real boards and QEMU.
2. Enables all platform-specific drivers and features.

The first patch definitely should go in, as it is a de-facto bug fix.
The second has been suggested to increase build coverage.

I've tried to keep the changes to minimum. The patches can be also
pulled as described below.

Cheers!

Pawel


The following changes since commit 61e6cfa80de5760bbe406f4e815b7739205754d2:

  Linux 3.12-rc5 (2013-10-13 15:41:28 -0700)

are available in the git repository at:

  git://git.linaro.org/people/pawelmoll/linux.git tags/vexpress/defconfig-for-v3.13

for you to fetch changes up to 04650cf989f418b7c28f94d63c0c174d34e0a9ad:

  ARM: vexpress: Enable platform-specific options in defconfig (2013-10-16 14:23:25 +0100)

----------------------------------------------------------------
Fathi Boudra (1):
  ARM: vexpress: Make defconfig work again

Pawel Moll (1):
  ARM: vexpress: Enable platform-specific options in defconfig

 arch/arm/configs/vexpress_defconfig | 72 +++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 26 deletions(-)

-- 
1.8.1.2
