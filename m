From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 7 Aug 2015 18:27:54 +0200
Subject: [GIT PULL] at91: defconfig for 4.3 #2
Message-ID: <20150807162754.GA20169@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

A little defconfig update. That will probably be all for this cycle.

Thanks, bye,


The following changes since commit eff7f41572a645bf14a96a6f844be4f1c88cd9dd:

  ARM: at91: at91_dt_defconfig: enable ISI and ov2640 support (2015-07-30 14:17:31 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-defconfig2

for you to fetch changes up to ea7bf603fd494391acc1f42acbfc34260b965c44:

  ARM: at91/defconfig: at91_dt: remove ARM_AT91_ETHER (2015-08-07 12:07:50 +0200)

----------------------------------------------------------------
Second batch of defconfig update for 4.3:
- enable the HLCDC driver for at91sam9
- remove an obsolete config option

----------------------------------------------------------------
Alexandre Belloni (1):
      ARM: at91/defconfig: at91_dt: remove ARM_AT91_ETHER

Josh Wu (1):
      ARM: at91/defconfig: at91_dt: enable DRM hlcdc support

 arch/arm/configs/at91_dt_defconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
