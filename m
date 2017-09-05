From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue,  5 Sep 2017 20:06:51 +0200
Subject: [PATCH 0/2] arm64: Cleanups if modules are disabled
Message-ID: <1504634813-29554-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Catalin, Will,

This patch series disables printing and reservation of virtual memory for
modules if module support is disabled.

The two patches are independent of each other.

Thanks for your comments!

Geert Uytterhoeven (2):
  arm64: Do not print virtual memory for modules if modules are disabled
  arm64: Do not reserve virtual memory for modules if modules are
    disabled

 arch/arm64/include/asm/memory.h | 4 ++++
 arch/arm64/mm/init.c            | 2 ++
 2 files changed, 6 insertions(+)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
