From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 4 Apr 2016 11:06:31 +0200
Subject: [GIT PULL] Versatile cleanups
Message-ID: <CACRpkdYcBgOOuQd9rf+DEXnqhG9Yuif_ir_xOozLXQpuToD-Fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC folks,

here are some Versatile cleanups that missed the last merge window.
Please merge them on some cleanup branch for the v4.7 series.

I might send more cleanups on top, I just don't want more stuff lying
around and not getting upstream.

Yours,
Linus Walleij

The following changes since commit 9735a22799b9214d17d3c231fe377fc852f042e9:

  Linux 4.6-rc2 (2016-04-03 09:09:40 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/versatile-cleanup-1

for you to fetch changes up to 7fbbe38aa11816ef15844238e8eb3164b887d265:

  ARM: realview: hide unused 'pmu_device' object (2016-04-04 10:58:47 +0200)

----------------------------------------------------------------
Versatile cleanups for the v4.7 series:
- Dynamically detect and print HBI numbers in SoC sysfs
- Hide the unused "pmu_device"

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: realview: hide unused 'pmu_device' object

Linus Walleij (1):
      soc: versatile: dynamically detect RealView HBI numbers

 arch/arm/mach-realview/realview_pbx.c |  2 ++
 drivers/soc/versatile/soc-realview.c  | 19 ++++---------------
 2 files changed, 6 insertions(+), 15 deletions(-)
