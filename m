From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 17 Jan 2017 21:03:03 +0100
Subject: [GIT PULL] ARM: at91: drivers for 4.11
Message-ID: <20170117200303.ycriqdrdwo5usccc@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

This is a single fix for the atmel-ebi.

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.11-drivers

for you to fetch changes up to ee194289502a6901cc77dc9a893bf2afd351ac5e:

  memory/atmel-ebi: Fix ns <-> cycles conversions (2017-01-10 16:01:34 +0100)

----------------------------------------------------------------
Drivers for 4.11:

 - atmel-ebi: Fix ns <-> cycles conversions

----------------------------------------------------------------
Boris Brezillon (1):
      memory/atmel-ebi: Fix ns <-> cycles conversions

 drivers/memory/atmel-ebi.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
