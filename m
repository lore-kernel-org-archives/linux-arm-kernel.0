From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 12 Jun 2017 11:32:15 +0200
Subject: [PATCH 0/2] arm64: dts: renesas: Add reset control properties for
 audio
Message-ID: <1497259937-9387-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus, Morimoto-san,

This patch series describes all resets wired to the audio modules on
R-Car Gen3 SoCs, following the DT binding update in commit
5f440c48c5d5a11f ("ASoC: rsnd: Document optional reset properties") in
sound-asoc/for-next.

Thanks!

Geert Uytterhoeven (2):
  arm64: dts: r8a7795: Add reset control properties for audio
  arm64: dts: r8a7796: Add reset control properties for audio

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 10 ++++++++++
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 10 ++++++++++
 2 files changed, 20 insertions(+)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
