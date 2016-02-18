From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 18 Feb 2016 02:56:34 +0100
Subject: [GIT PULL] at91: defconfig for 4.6 #1
Message-ID: <20160218015634.GA31609@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

A defconfig update, adding the sama5d2 ADC to sama5_defconfig.

Thanks,


The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.6-defconfig

for you to fetch changes up to 48a2e12adb7f4d1a03720d3923bedbc13ab96143:

  ARM: at91/defconfig: add sama5d2 adc support in sama5_defconfig (2016-02-17 22:51:48 +0100)

----------------------------------------------------------------
defconfig update for 4.6:
 - Addition of sama5d2 ADC to sama5_defconfig

----------------------------------------------------------------
Ludovic Desroches (1):
      ARM: at91/defconfig: add sama5d2 adc support in sama5_defconfig

 arch/arm/configs/sama5_defconfig | 1 +
 1 file changed, 1 insertion(+)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
