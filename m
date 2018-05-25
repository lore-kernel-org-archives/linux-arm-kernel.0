From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Sat, 26 May 2018 00:50:33 +0200
Subject: [GIT PULL] ARM: at91: DT for 4.18
Message-ID: <20180525225033.GA26989@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

I'm a bit late for this very small PR, as I had to extend the expiration
date for my GPG signature key.

Two small DT changes that have no functional impact.

The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:

  Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.18-dt

for you to fetch changes up to a642693882ce417683012a211ca9d6e65bae1dc4:

  ARM: dts: at91-sama5d2_xplained: Use IRQ_TYPE specifier (2018-05-14 15:29:52 +0200)

----------------------------------------------------------------
AT91 DT for 4.18:

 - small DT improvements without functional changes

----------------------------------------------------------------
Dmitry Torokhov (1):
      ARM: dts: at91: sama5d4ek: use canonical compatible for touchscreen

Hern?n Gonzalez (1):
      ARM: dts: at91-sama5d2_xplained: Use IRQ_TYPE specifier

 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 2 +-
 arch/arm/boot/dts/at91-sama5d4ek.dts        | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
