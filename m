From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 19 Oct 2015 23:21:05 +0200
Subject: [GIT PULL] at91: soc for 4.4 #2
Message-ID: <20151019212105.GA6134@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

This is a great fix for PM and suspend/resume for 4.4

Thanks,

The following changes since commit 6f112a08c1ed717a015dae190e289d53085c1bc4:

  ARM: at91: debug: use DEBUG_UART_PHYS (2015-09-21 16:31:15 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-soc2

for you to fetch changes up to 5fcf8d1a0e84792b2bc44922c5d833dab96a9c1e:

  ARM: at91: pm: at91_pm_suspend_in_sram() must be 8-byte aligned (2015-10-19 22:58:44 +0200)

----------------------------------------------------------------
More SoC changes for 4.4:
 - a great fix for PM/suspend/resume

----------------------------------------------------------------
Patrick Doyle (1):
      ARM: at91: pm: at91_pm_suspend_in_sram() must be 8-byte aligned

 arch/arm/mach-at91/pm_suspend.S | 2 ++
 1 file changed, 2 insertions(+)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
