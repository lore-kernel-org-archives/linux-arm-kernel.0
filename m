From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Tue, 25 Sep 2018 12:53:44 +0200
Subject: [GIT PULL] ARM: at91: defconfig for 4.20
Message-ID: <20180925105344.GA32532@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof

The addition of the generic ADC touchscreen driver can probably benefit
other architectures. Also add the sama5 I2S driver.

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-4.20-defconfig

for you to fetch changes up to 4eb2534057b1b01014a2b2bb6898d9934d2ba831:

  ARM: multi_v7_defconfig: add Atmel I2S driver (2018-08-30 22:19:32 +0200)

----------------------------------------------------------------
AT91 defconfig for 4.20

 - addition of sama5 I2S
 - addition of generic ADC resistive touchscreen

----------------------------------------------------------------
Codrin Ciubotariu (2):
      ARM: configs: at91: Add I2S driver to sama5
      ARM: multi_v7_defconfig: add Atmel I2S driver

Eugen Hristev (2):
      ARM: configs: at91: add generic resistive touchscreen to sama5
      ARM: multi_v7_defconfig: add generic resistive touchscreen

 arch/arm/configs/multi_v7_defconfig | 2 ++
 arch/arm/configs/sama5_defconfig    | 2 ++
 2 files changed, 4 insertions(+)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
