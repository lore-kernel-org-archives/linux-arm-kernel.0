From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 28 May 2018 22:03:17 +0200
Subject: [GIT PULL] pxa for v4.18
Message-ID: <87d0xftunu.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof,

This is the pxa pull request for 4.18, a minor one.

Can you please consider pulling ?

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-for-4.18

for you to fetch changes up to c1c14f8954c6d1cb9867024618e93687d9d035ba:

  ARM: pxa3xx: enable external wakeup pins (2018-05-25 22:40:17 +0200)

----------------------------------------------------------------
This is is the pxa changes for v4.18 cycle :
 - change to phase out at24 eeprom platform data
 - add a missing wakeup pin on pxa320 SoCs

----------------------------------------------------------------
Bartosz Golaszewski (1):
      ARM: pxa: stargate2: use device properties for at24 eeprom

Daniel Mack (1):
      ARM: pxa3xx: enable external wakeup pins

 arch/arm/mach-pxa/pxa3xx.c    |  4 ++++
 arch/arm/mach-pxa/stargate2.c | 10 +++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

-- 
Robert
