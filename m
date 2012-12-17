From: rmallon@gmail.com (Ryan Mallon)
Date: Tue, 18 Dec 2012 09:41:09 +1100
Subject: [GIT PULL] ep93xx-fixes for 3.8
Message-ID: <50CF9F85.4090000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

I hope I am not too late with this. Just one small fix for the early
UART code.

Thanks,
~Ryan

----

The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://github.com/RyanMallon/linux-ep93xx.git tags/ep93xx-fixes-for-3.8

for you to fetch changes up to 210dce5faf89c9677ac1a6273bc53f130843539f:

  ARM: ep93xx: properly wait for UART FIFO to be empty (2012-12-12
11:22:56 +1100)

----------------------------------------------------------------
Florian Fainelli (1):
      ARM: ep93xx: properly wait for UART FIFO to be empty

 arch/arm/mach-ep93xx/include/mach/uncompress.h |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)
