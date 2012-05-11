From: rmallon@gmail.com (Ryan Mallon)
Date: Fri, 11 May 2012 10:55:37 +1000
Subject: [GIT PULL] ep93xx cleanups for 3.5
Message-ID: <4FAC6389.40607@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 0034102808e0dbbf3a2394b82b1bb40b5778de9e:

  Linux 3.4-rc2 (2012-04-07 18:30:41 -0700)

are available in the git repository at:

  git://github.com/RyanMallon/linux-ep93xx.git tags/ep93xx-cleanup-for-3.5

for you to fetch changes up to a1eacd79a602707f97201edbac9a03edaaea1847:

  arm: ep93xx: use gpio_led_register_device (2012-04-12 09:38:15 +1000)

----------------------------------------------------------------
H Hartley Sweeten (2):
      arm: ep93xx: use DEFINE_RES_* macros
      arm: ep93xx: use gpio_led_register_device

Ryan Mallon (1):
      Fix build breakage in ep93xx-core

 arch/arm/mach-ep93xx/Kconfig |    5 ++
 arch/arm/mach-ep93xx/core.c  |  110 ++++++++----------------------------------
 2 files changed, 25 insertions(+), 90 deletions(-)
