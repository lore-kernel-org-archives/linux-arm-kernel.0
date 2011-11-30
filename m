From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 30 Nov 2011 17:53:01 +0100
Subject: [GIT PULL] at91 fixes for 3.2-rc4
Message-ID: <4ED65F6D.4020402@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Here are a few fixes for AT91. I have noted 3.2-rc4 in the subject but it
is true that it can go in another -rc revision as I have seen your recent
pull request to Linus...

The following changes since commit caca6a03d365883564885f2c1da3e88dcf65d139:

  Linux 3.2-rc3 (2011-11-23 20:20:28 -0800)

are available in the git repository at:
  git://github.com/at91linux/linux-at91.git at91-fixes

Anders Darander (1):
      ARM: at91: Fix USB AT91 gadget registration

Christian Hitz (1):
      ARM: at91: fix NAND bus width decoding from system_rev

Jean-Christophe PLAGNIOL-VILLARD (1):
      ARM: at91: fix clock conid for atmel_tcb.1 on 9260/9g20

 arch/arm/mach-at91/at91rm9200_devices.c      |    2 +-
 arch/arm/mach-at91/at91sam9260.c             |    6 +++---
 arch/arm/mach-at91/at91sam9260_devices.c     |    2 +-
 arch/arm/mach-at91/at91sam9261_devices.c     |    2 +-
 arch/arm/mach-at91/at91sam9263_devices.c     |    2 +-
 arch/arm/mach-at91/include/mach/system_rev.h |    2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

Thanks, best regards,
-- 
Nicolas Ferre
