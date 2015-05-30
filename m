From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sat, 30 May 2015 14:21:29 +0900
Subject: [GIT PULL] ARM: EXYNOS: More defconfig for 4.2
Message-ID: <1432963289-32664-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kukjin,

Minor defconfig changes from Anand Moon for Odroid XU3 board.
You can find them also on the lists with my reviewed-by.

Best regards,
Krzysztof


The following changes since commit 030bbdbf4c833bc69f502eae58498bc5572db736:

  Linux 4.1-rc3 (2015-05-10 15:12:29 -0700)

are available in the git repository at:

  https://github.com/krzk/linux.git tags/samsung-defconfig-for-4.2

for you to fetch changes up to 314be0834460dfde70b614f1a2e5d041684ce796:

  ARM: exynos_defconfig: Enable LEDs for Odroid-XU3 (2015-05-30 13:19:49 +0900)

----------------------------------------------------------------
Enable in exynos_defconfig options for Odroid XU3:
1. sensors (fan, ina231),
2. LED.

----------------------------------------------------------------
Anand Moon (3):
      ARM: exynos_defconfig: Enable CONFIG_SENSORS_PWM_FAN for Odroid-XU3 pmw-fan
      ARM: exynos_defconfig: Enable CONFIG_SENSORS_INA2XX for Odroid-XU3
      ARM: exynos_defconfig: Enable LEDs for Odroid-XU3

 arch/arm/configs/exynos_defconfig | 5 +++++
 1 file changed, 5 insertions(+)
