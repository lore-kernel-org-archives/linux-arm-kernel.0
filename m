From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 28 Apr 2015 12:29:20 +0200
Subject: [PATCH 0/3] ARM: shmobile: Use generic names for sound device nodes
Message-ID: <1430216963-8161-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Magnus, Simon,

This patch series gets rid of the "sound-codec" device nodes names in
the shmobile DTS files, and replaces them by "codec", as the former
doesn't appear in any binding document.

Thanks for applying!

Geert Uytterhoeven (3):
  ARM: shmobile: bockw dts: Use generic names for device nodes
  ARM: shmobile: lager dts: Use generic names for device nodes
  ARM: shmobile: koelsch dts: Use generic names for device nodes

 arch/arm/boot/dts/r8a7778-bockw.dts   | 2 +-
 arch/arm/boot/dts/r8a7790-lager.dts   | 2 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
