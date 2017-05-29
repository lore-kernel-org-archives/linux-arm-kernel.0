From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 29 May 2017 11:23:15 +0200
Subject: [GIT PULL] ARM: at91: fixes for 4.12
Message-ID: <20170529092315.kvlx7oioxjlv34ky@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here are two fixes for 4.12.

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-4.12-fixes

for you to fetch changes up to cc7a938f5f308eeb6f8fe3cec28e1800aa81facb:

  ARM: at91: select CONFIG_ARM_CPU_SUSPEND (2017-05-29 11:06:56 +0200)

----------------------------------------------------------------
Fixes for 4.12:

Fix two compilation issues

----------------------------------------------------------------
Arnd Bergmann (2):
      memory: atmel-ebi: mark PM ops as __maybe_unused
      ARM: at91: select CONFIG_ARM_CPU_SUSPEND

 arch/arm/mach-at91/Kconfig | 1 +
 drivers/memory/atmel-ebi.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
