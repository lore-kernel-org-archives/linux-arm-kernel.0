From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 09 Aug 2016 20:47:47 +0200
Subject: [GIT PULL] pxa fixes for v4.8
Message-ID: <87fuqdvkx8.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello Arnd, Kevin, Olof,

Please consider this pull request for pxa fixes for 4.8, made of 2 trivial
fixes. It's pretty unconventional, as I missed the 4.8-rc1 merge window, but
these are only 2 includes modifications, and it loosens the bond on gpio API for
future module.h include removal.

Let me know if you judge that safe enough as I did to let that in a -rc cycle.

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-fixes-v4.8

for you to fetch changes up to a3c747b96df66a7eb810fef45f3b9e65614712d9:

  ARM: pxa: add module.h for corgi symbol_get/symbol_put usage (2016-08-09 08:19:06 +0200)

----------------------------------------------------------------
This is the pxa changes for v4.8 cycle.

This is a tiny fix couple to enable changes in includes in
gpio API without breaking pxa boards.

----------------------------------------------------------------
Paul Gortmaker (2):
      ARM: pxa: add module.h for spitz symbol_get/symbol_put usage
      ARM: pxa: add module.h for corgi symbol_get/symbol_put usage

 arch/arm/mach-pxa/corgi.c | 1 +
 arch/arm/mach-pxa/spitz.c | 1 +
 2 files changed, 2 insertions(+)

Cheers.

-- 
Robert
