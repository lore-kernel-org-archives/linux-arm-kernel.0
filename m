From: stigge@antcom.de (Roland Stigge)
Date: Wed, 18 Jul 2012 14:06:47 +0200
Subject: [PATCH 0/4] ARM: LPC32xx specific updates for next, third set
Message-ID: <1342613211-13190-1-git-send-email-stigge@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the third round of patches for mach-lpc32xx, for v3.6. This time,
patches from Alexandre, for PWM support and CPU ID.

If no objections surface, I'll provide pull requests for arm-soc branches
shortly.

Signed-off-by: Roland Stigge <stigge@antcom.de>

--
Alexandre Pereira da Silva (4):
 ARM: LPC32xx: Set system serial based on cpu unique id
 ARM: LPC32xx: Add PWM clock
 ARM: LPC32xx: Add PWM support
 ARM: LPC32xx: Add PWM to base dts file

 arch/arm/Kconfig               |    1 +
 arch/arm/boot/dts/lpc32xx.dtsi |   11 +++++++++++
 arch/arm/mach-lpc32xx/clock.c  |   14 ++++++++++++++
 arch/arm/mach-lpc32xx/common.c |   10 ++++++++--
 4 files changed, 34 insertions(+), 2 deletions(-)
