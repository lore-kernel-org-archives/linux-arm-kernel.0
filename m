From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 Feb 2012 17:07:22 +0100
Subject: [GIT PULL] ux500 patches for v3.4 take 2
Message-ID: <1330099642-6265-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi ARM-SoC maintainers,

this is an iteration of the former pull request for the
ux500 changes, replacing the U9540 patch with a v2 version
without the IRQs defined, planning to get these into
the device tree.

Thanks,
Linus Walleij


The following changes since commit b01543dfe67bb1d191998e90d20534dc354de059:

  Linux 3.3-rc4 (2012-02-18 15:53:33 -0800)

are available in the git repository at:
  git://git.linaro.org/people/triad/linux-stericsson.git/ ..BRANCH.NOT.VERIFIED..

Linus Walleij (1):
      ARM: ux500: core U9540 support

Michel Jaouen (1):
      ARM: ux500: ioremap differences for DB9540

Ola Lilja (3):
      ARM: ux500: Add placeholder for clk_set_parent
      ARM: ux500: Add DMA-channels for MSP
      ARM: ux500: Add audio-regulators

Philippe Langlais (2):
      ARM: ux500: set ARCH_NR_GPIO to 355 on U8500 platforms
      ARM: ux500: fix around AB8500 GPIO macro name

 arch/arm/Kconfig                               |    2 +-
 arch/arm/mach-ux500/board-mop500-regulators.c  |   28 ++++++++++++++++++++++++
 arch/arm/mach-ux500/board-mop500-uib.c         |    2 +-
 arch/arm/mach-ux500/board-mop500.c             |    2 +-
 arch/arm/mach-ux500/board-mop500.h             |    2 +-
 arch/arm/mach-ux500/cache-l2x0.c               |   14 ++++++++++-
 arch/arm/mach-ux500/clock.c                    |    9 ++++++-
 arch/arm/mach-ux500/clock.h                    |    1 +
 arch/arm/mach-ux500/cpu-db8500.c               |   24 +++++++++++++++++---
 arch/arm/mach-ux500/cpu.c                      |    4 +-
 arch/arm/mach-ux500/devices-db8500.c           |    6 +++++
 arch/arm/mach-ux500/id.c                       |   26 ++++++++++++++++++++++
 arch/arm/mach-ux500/include/mach/db8500-regs.h |    6 +++++
 arch/arm/mach-ux500/include/mach/hardware.h    |   12 ++++++++++
 arch/arm/mach-ux500/include/mach/id.h          |   17 +++++++++++++-
 arch/arm/mach-ux500/include/mach/irqs.h        |    2 +-
 arch/arm/mach-ux500/include/mach/setup.h       |    7 ++++++
 arch/arm/mach-ux500/platsmp.c                  |    4 +-
 arch/arm/mach-ux500/timer.c                    |    2 +-
 drivers/cpufreq/db8500-cpufreq.c               |    2 +-
 20 files changed, 153 insertions(+), 19 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPR0U7AAoJEEEQszewGV1z4wIQAIXY6g66kHYZzi00j1qyuEay
1oRz38jur1DIM+MHDarpId36sZt9QRQ/aCXMYk855i41dwXCXTMtvNrnRWqRdJsz
VOJR+XoNkZLhrxFUAdOQ2jSp1jpDEaaiklm/UjpYOb6JoXTqcI8ktz2Av3w9YWwG
o/l7fFgFxm8Poa2tBdEj8zoQrWMH7XsG/LzP84gJW8yi0BhNIOlTYXpsWqJlHsY2
M4K2Thb+6h2Q/AtMSICbuYC102AVg+MOGZRrZmO0koDsRi5h795lEzJ/GaavpaGx
hJF17czDq0VDYpcSA6UwdomfzQOXGpORJI3+PJa8qKLN9CfjaYus9Tw7JcmJ9PWV
2YEc2H6IT+MPDWqdwPwUhEP8iXsw/hcTgQ2gsP2f/6MG0d0cCMCsFHa9jrCti2o0
t4MvJB/AimbbNXHI1z/DqBc8/swkf6wrqOSGMGj7G5GpTp6GymNj1DsDQmMVJpcP
VpN0Bt3CzodY9jRUpvnH9Yth7cD4WmzQ/HLYUyz98u0bxU4xCnmuYZ7XIokGj4lv
+Chr0iJljnlQ44rdAu3wI8B+NO8UOhonh1M1/jMUeHJXzLpRDNQQKI88scNKPL/x
SEXumMz29IMWnbGVKjroSkGq+6HqZqTUihTiNfbqZ4FFSOdSjytyTMPMPHpAnOVw
s7AFEcIfbJEL1JN5GZ/6
=N9e7
-----END PGP SIGNATURE-----
