From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 11 Jul 2016 09:34:17 +0200
Subject: [GIT PULL/PATCH] Fix for current cycle - v4.7
Message-ID: <1468222458-4265-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

I got only one fix for this release cycle, so can you apply it directly
instead of pull request?

Best regards,
Krzysztof

Alim Akhtar (1):
  arm64: dts: Fix RTC by providing rtc_src clock

 arch/arm64/boot/dts/exynos/exynos7-espresso.dts | 3 +++
 1 file changed, 3 insertions(+)

-- 
1.9.1
