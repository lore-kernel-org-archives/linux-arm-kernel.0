From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri,  2 Mar 2018 14:56:29 +0100
Subject: [PATCH v4 0/4] DT: Fix spelling of standard properties
Message-ID: <1519998993-14398-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi all,

This patch series fixes misspellings of various standard DT properties
in DT binding documentation, DTS files, and examples.
While most of these are harmless, some of them may cause hard-to-debug
failures.

Changes compared to v4:
  - Drop patches that have been applied already,
  - Add Acked-by.

Changes compared to v3:
  - Drop patches that have been applied already,
  - Add Acked-by,
  - Add new patches 5 and 6.

Changes compared to v2:
  - Drop patches that have been applied already,
  - Add Rob Herring's Acked-by,
  - Add new patch "[PATCH v2 3/6] arm64: dts: lg1313: DT fix
    s/#interrupts-cells/#interrupt-cells/".

Please apply where appropriate.

Thanks!

Geert Uytterhoeven (4):
  arm64: dts: lg1312: DT fix s/#interrupts-cells/#interrupt-cells/
  arm64: dts: lg1313: DT fix s/#interrupts-cells/#interrupt-cells/
  dt-bindings: display: amlogic: DT fix s/resets-names/reset-names/
  dt-bindings: net: btusb: DT fix s/interrupt-name/interrupt-names/

 Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.txt | 2 +-
 Documentation/devicetree/bindings/net/btusb.txt                     | 2 +-
 arch/arm64/boot/dts/lg/lg1312.dtsi                                  | 2 +-
 arch/arm64/boot/dts/lg/lg1313.dtsi                                  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
