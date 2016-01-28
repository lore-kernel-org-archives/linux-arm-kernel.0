From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 28 Jan 2016 16:17:24 +0100
Subject: [PATCH 0/2] ARM: shmobile: Remove legacy machine_desc.map_io()
 callbacks
Message-ID: <1453994246-12886-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

This patch series removes the legacy machine_desc.map_io() callback for
SoCs that no longer rely on it, but use ioremap() instead.

The patch for emev2 depends on "ARM: shmobile: Consolidate SCU mapping
code" ("FIXME" commit ID reference to be updated).

Thanks!

Geert Uytterhoeven (2):
  ARM: shmobile: r8a7740: Remove legacy machine_desc.map_io() callback
  ARM: shmobile: emev2: Remove legacy machine_desc.map_io() callback

 arch/arm/mach-shmobile/setup-emev2.c   | 18 ------------------
 arch/arm/mach-shmobile/setup-r8a7740.c | 20 --------------------
 2 files changed, 38 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
