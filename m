From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 28 Nov 2011 11:31:15 +0100
Subject: [GIT PULL] at91 IIO/ADC platform data for 3.2
Message-ID: <4ED362F3.3010500@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

I would like to know if it is possible for you to integrate this platform data
structure definition during 3.2-rc cycle. We discussed with Jonathan and Maxime
and we found it interesting to integrate this quite early to accompany the move
of IIO subsystem from staging to mainline kernel.
The AT91 ADC driver will then be integrated during 3.3 phase together with the 
board support that will use this platform data (and future device tree bindings).

It is a single patch based on 3.2-rc3:

The following changes since commit caca6a03d365883564885f2c1da3e88dcf65d139:

  Linux 3.2-rc3 (2011-11-23 20:20:28 -0800)

are available in the git repository at:
  git://github.com/at91linux/linux-at91.git for-arnd-3.2-ADC

Maxime Ripard (1):
      ARM: AT91: Add platform data for the ADCs

 arch/arm/mach-at91/include/mach/board.h |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)


Thanks, best regards,
-- 
Nicolas Ferre
