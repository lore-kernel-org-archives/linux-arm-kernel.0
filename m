From: kevin.wells@nxp.com (Kevin Wells)
Date: Wed, 6 Apr 2011 00:45:31 +0200
Subject: GIT pull request:lpc32xx core updates
Message-ID: <083DF309106F364B939360100EC290F811EDEE8ABA@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(resend - original stuck in moderator review)

Hi Russell,

Can you please pull these reviewed updates for the LPC32xx?

  git://git.lpclinux.com/linux-2.6-lpc for_rmk_32xx_04_05

Wolfram Sang (3):
      arm: lpc32xx: add tsc-device
      arm: lpc32xx: add rtc-device
      arm: lpc32xx: clock: use bool logic instead of binary

 arch/arm/mach-lpc32xx/clock.c  |    4 +-
 arch/arm/mach-lpc32xx/common.c |   42 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-lpc32xx/common.h |    2 +
 3 files changed, 46 insertions(+), 2 deletions(-)

thanks,
Kevin Wells
NXP Semicon1
ductors
