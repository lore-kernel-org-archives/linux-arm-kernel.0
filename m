From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 28 Jan 2017 01:45:10 +0100
Subject: [GIT PULL] ARM: at91: drivers for 4.11 #2
Message-ID: <20170128004510.w4ke4ccrqixvq3do@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof

The EBI was requiring more fixing than expected in preparation of the
NAND driver rework for 4.12.

The following changes since commit ee194289502a6901cc77dc9a893bf2afd351ac5e:

  memory/atmel-ebi: Fix ns <-> cycles conversions (2017-01-10 16:01:34 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.11-drivers2

for you to fetch changes up to 87108dc78eb8935b5cebab70f8158807d5a7617f:

  memory: atmel-ebi: Enable the SMC clock if specified (2017-01-27 10:28:54 +0100)

----------------------------------------------------------------
Drivers for 4.11 #2:

 - more EBI fixes

----------------------------------------------------------------
Boris Brezillon (3):
      memory: atmel-ebi: Fix the test to enable generic SMC logic
      memory: atmel-ebi: Properly handle multiple reference to the same CS
      memory: atmel-ebi: Enable the SMC clock if specified

 drivers/memory/atmel-ebi.c | 99 ++++++++++++++++++++++++++++++----------------
 1 file changed, 65 insertions(+), 34 deletions(-)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
