From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 24 Nov 2015 18:08:27 +0900
Subject: [PATCH 0/2] arm64: initial series for UniPhier ARMv8 SoCs support
Message-ID: <1448356109-22380-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

This series adds ARM64 Linux support for Socionext's UniPhier SoCs.

The device trees will be sent in another series.



Masahiro Yamada (2):
  arm64: add Kconfig entry for Socionext UniPhier SoC family
  arm64: defconfig: enable UniPhier SoCs support

 arch/arm64/Kconfig.platforms | 6 ++++++
 arch/arm64/configs/defconfig | 2 ++
 2 files changed, 8 insertions(+)

-- 
1.9.1
