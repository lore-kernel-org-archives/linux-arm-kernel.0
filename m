From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun,  6 May 2018 15:43:45 +0200
Subject: [PATCH 0/7] Gemini DTS updates
Message-ID: <20180506134352.2637-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a resend of some patches and some new fixups for
the Gemini device trees. Will send a v4.18 pull request for
this stuff in a few days.

Geert Uytterhoeven (1):
  ARM: dts: gemini: Fix "debounce-interval" property misspelling

Linus Walleij (6):
  ARM: dtd: Set DNS-313 LEDs to use better triggers
  ARM: dts: Set DNS-685 LEDs to use better triggers
  ARM: dts: Fix the DNS-313 flash compatible
  ARM: dts: Fix bootargs for Gemini D-Link devices
  ARM: dts: Add second ATA to NAS4220B
  ARM: dts: Fix DTC warnings

 arch/arm/boot/dts/gemini-dlink-dir-685.dts | 16 +++++++++-------
 arch/arm/boot/dts/gemini-dlink-dns-313.dts | 19 +++++++++++--------
 arch/arm/boot/dts/gemini-nas4220b.dts      | 20 +++++++++++---------
 arch/arm/boot/dts/gemini-rut1xx.dts        | 12 +++++-------
 arch/arm/boot/dts/gemini-sq201.dts         | 12 +++++-------
 arch/arm/boot/dts/gemini-wbd111.dts        | 17 ++++++++---------
 arch/arm/boot/dts/gemini-wbd222.dts        | 16 +++++++---------
 7 files changed, 56 insertions(+), 56 deletions(-)

-- 
2.17.0
