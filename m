From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 20 Nov 2018 13:31:20 +0100
Subject: [PATCH 0/5] ARM: davinci: set GPIO base to 0 manually
Message-ID: <20181120123125.24938-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

This is a follow-up to the series that fixes a problem with ethernet
on da850-evm. All DaVinci boards in legacy mode were broken by commit
587f7a694f01 ("gpio: davinci: Use dev name for label and automatic
base selection"). This series sets the GPIO base to 0 manually for all
DaVinci SoCs.

Bartosz Golaszewski (5):
  ARM: davinci: dm365: set the GPIO base to 0
  ARM: davinci: dm646x: set the GPIO base to 0
  ARM: davinci: dm355: set the GPIO base to 0
  ARM: davinci: da830: set the GPIO base to 0
  ARM: davinci: dm644x: set the GPIO base to 0

 arch/arm/mach-davinci/da830.c  | 2 ++
 arch/arm/mach-davinci/dm355.c  | 2 ++
 arch/arm/mach-davinci/dm365.c  | 2 ++
 arch/arm/mach-davinci/dm644x.c | 2 ++
 arch/arm/mach-davinci/dm646x.c | 2 ++
 5 files changed, 10 insertions(+)

-- 
2.19.1
