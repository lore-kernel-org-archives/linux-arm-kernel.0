From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 29 Mar 2017 14:38:41 -0700
Subject: [GIT PULL] Amlogic: defconfig changes for v4.12
Message-ID: <m2shlv69we.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-defconfig

for you to fetch changes up to 95fbe8b08b2d420e4f5a77701f165d6b23827862:

  ARM64: defconfig: enable the leds-pwm driver and default-on trigger (2017-03-06 09:54:57 -0800)

----------------------------------------------------------------
Amlogic: defconfig changes for v4.12
- enable PWM LEDs and LEDs default-on trigger

----------------------------------------------------------------
Martin Blumenstingl (1):
      ARM64: defconfig: enable the leds-pwm driver and default-on trigger

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)
