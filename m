From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 19 Nov 2016 16:48:25 +0200
Subject: [PATCH 0/6] ASoC: samsung: Minor cleanup for old machines
Message-ID: <1479566911-5580-1-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Few patches removing dead code (machines not supported).

The third patch ([RFT 3/6] ASoC: samsung: smdk_wm8580: Remove machine
specific quirks) requires testing. I hope I understood the code
correctly.

The last ARM patch is independent. I will take it through samsung-soc
tree. I put it here for reference.

Best regards,
Krzysztof

Krzysztof Kozlowski (6):
  ASoC: samsung: Remove non-existing MACH dependencies
  ASoC: samsung: smdk_wm8580: Remove old platforms and drop mach-types
    usage
  ASoC: samsung: smdk_wm8580: Remove machine specific quirks
  ASoC: samsung: Enable COMPILE_TEST for SmartQ and WM8580
  ASoC: samsung: Enable COMPILE_TEST for entire Samsung ASoc
  ARM: s5pv210_defconfig: Remove old MACHs

 arch/arm/configs/s5pv210_defconfig |  4 ----
 sound/soc/samsung/Kconfig          |  8 +++++---
 sound/soc/samsung/smdk_wm8580.c    | 17 ++---------------
 3 files changed, 7 insertions(+), 22 deletions(-)

-- 
2.7.4
