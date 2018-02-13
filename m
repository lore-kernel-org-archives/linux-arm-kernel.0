From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 13 Feb 2018 15:15:00 +0100
Subject: [PATCH 0/9] DT: Fix "debounce-interval" property misspellings
Message-ID: <1518531309-5039-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi all,

This patch series fixes various misspellings of the "debounce-interval"
DT property.

Thanks for applying where appropriate!

Geert Uytterhoeven (9):
  dt-bindings: power: Fix "debounce-interval" property misspelling
  ARM: dts: atlas7: Fix "debounce-interval" property misspelling
  ARM: dts: kzm9d: Fix "debounce-interval" property misspelling
  ARM: dts: exynos: Fix "debounce-interval" property misspelling
  ARM: dts: gemini: Fix "debounce-interval" property misspelling
  ARM: dts: kirkwood: Fix "debounce-interval" property misspelling
  ARM: dts: OMAP5: uevm: Fix "debounce-interval" property misspelling
  ARM: dts: Ux500: Fix "debounce-interval" property misspelling
  arm64: dts: juno: Fix "debounce-interval" property misspelling

 Documentation/devicetree/bindings/power/wakeup-source.txt |  2 +-
 arch/arm/boot/dts/atlas7-evb.dts                          |  2 +-
 arch/arm/boot/dts/emev2-kzm9d.dts                         |  8 ++++----
 arch/arm/boot/dts/exynos4412-trats2.dts                   |  2 +-
 arch/arm/boot/dts/gemini-dlink-dir-685.dts                |  4 ++--
 arch/arm/boot/dts/gemini-dlink-dns-313.dts                |  2 +-
 arch/arm/boot/dts/gemini-nas4220b.dts                     |  4 ++--
 arch/arm/boot/dts/gemini-rut1xx.dts                       |  2 +-
 arch/arm/boot/dts/gemini-sq201.dts                        |  2 +-
 arch/arm/boot/dts/gemini-wbd111.dts                       |  2 +-
 arch/arm/boot/dts/gemini-wbd222.dts                       |  2 +-
 arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts          |  2 +-
 arch/arm/boot/dts/omap5-uevm.dts                          |  2 +-
 arch/arm/boot/dts/ste-snowball.dts                        | 10 +++++-----
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi             | 12 ++++++------
 15 files changed, 29 insertions(+), 29 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
