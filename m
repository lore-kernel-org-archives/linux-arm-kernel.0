From: manabian@gmail.com (Joachim Eastwood)
Date: Sat, 10 Oct 2015 23:12:31 +0200
Subject: [GIT PULL] PL172 driver updates for v4.4
In-Reply-To: <1444511551-23853-1-git-send-email-manabian@gmail.com>
References: <1444511551-23853-1-git-send-email-manabian@gmail.com>
Message-ID: <1444511551-23853-2-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc team,

Please consider pulling these changes for memory/pl172 into
arm-soc/drivers.

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  https://github.com/manabian/linux-lpc.git tags/drivers_pl172_for_4.4

for you to fetch changes up to 961a86d22e89428516fa7183b7750a4ba9866f4d:

  doc: dt: arm,pl172: add description of PL175 and PL176 controllers (2015-09-29 22:19:02 +0200)

----------------------------------------------------------------
Support for additional ARM MPMCs to the PL172 driver and an update to
the bindings documentation to reflect this from Vladimir Zapolskiy.

"The change adds support of ARM PrimeCell PL175 MPMC and PL176 MPMC,
 the static memory controllers on devices are similar to one found on
 ARM PrimeCell PL172, add support to the existing driver."

----------------------------------------------------------------
Vladimir Zapolskiy (4):
      memory: pl172: correct MPMC peripheral ID register bits
      memory: pl172: add ARM PrimeCell PL175 MPMC support
      memory: pl172: add ARM PrimeCell PL176 MPMC support
      doc: dt: arm,pl172: add description of PL175 and PL176 controllers

 .../bindings/memory-controllers/arm,pl172.txt      |  8 ++++---
 drivers/memory/pl172.c                             | 26 +++++++++++++++++++---
 2 files changed, 28 insertions(+), 6 deletions(-)
