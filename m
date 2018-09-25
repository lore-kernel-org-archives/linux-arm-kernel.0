From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Tue, 25 Sep 2018 12:37:35 +0200
Subject: [GIT PULL] ARM: at91: SoC for 4.20
Message-ID: <20180925103735.GA31525@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Most changes are shuffling around the maintainers entries. There are
also two PM non urgent fixes.

This one as a trivial conflict with the staging tree solved in linux-next.

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-4.20-soc

for you to fetch changes up to 34d2a7db77ad837cfb88bd01b33fd1f3855ce9c0:

  MAINTAINERS: sdhci: move the Microchip entry to proper location (2018-09-25 12:26:31 +0200)

----------------------------------------------------------------
AT91 SoC for 4.20

 - rename MAINTAINERS entries and change maintainers
 - two pm cleanups

----------------------------------------------------------------
Claudiu Beznea (1):
      ARM: at91: pm: remove pm_bu initialization in at91_pm_backup_init()

Nicolas Ferre (11):
      MAINTAINERS: ARM: at91: add co-maintainer for ARM/Microchip
      MAINTAINERS: update entry for Microchip NAND driver support
      MAINTAINERS: media: change Microchip ISI, ISC maintainers
      MAINTAINERS: ASoC: change maintainer for Microchip ALSA drivers
      MAINTAINERS: USB: change maintainer for Microchip USBA gadget driver
      MAINTAINERS: dmaengine: add files to Microchip dma entry
      MAINTAINERS: pwm: add entry for Microchip pwm driver
      MAINTAINERS: iio: add co-maintainer to SAMA5D2-compatible ADC driver
      MAINTAINERS: remove the / ATMEL string from MICROCHIP entries
      MAINTAINERS: move former ATMEL entries to proper MICROCHIP location
      MAINTAINERS: sdhci: move the Microchip entry to proper location

zhong jiang (1):
      ARM: at91: pm: call put_device instead of of_node_put in at91_pm_config_ws

 MAINTAINERS             | 196 ++++++++++++++++++++++++++----------------------
 arch/arm/mach-at91/pm.c |   9 +--
 2 files changed, 108 insertions(+), 97 deletions(-)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
