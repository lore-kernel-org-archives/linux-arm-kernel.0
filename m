From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 23 Nov 2016 13:39:58 +0100
Subject: [git pull] Renesas RZ/G1M and RZ/G1E CPG Core Clock Definitions
Message-ID: <1479904798-12768-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Olof, Kevin, Arnd,

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git tags/rzg-clock-defs-tag1

for you to fetch changes up to 1fa8a875df6b8aa864f6c4f2b65dbc2ed477b859:

  clk: renesas: Add r8a7745 CPG Core Clock Definitions (2016-11-07 15:13:30 +0100)

----------------------------------------------------------------
Renesas RZ/G1M and RZ/G1E CPG Core Clock Definitions

This contains clock definitions shared by clock drivers and DTS files,
and is provided as a dependency for the latter.

This has already been pulled by Stephen as part of a larger pull
request, and is present in clk/clk-next, together with the corresponding
clock drivers.

Thanks for pulling!
----------------------------------------------------------------
Sergei Shtylyov (2):
      clk: renesas: Add r8a7743 CPG Core Clock Definitions
      clk: renesas: Add r8a7745 CPG Core Clock Definitions

 include/dt-bindings/clock/r8a7743-cpg-mssr.h | 43 +++++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7745-cpg-mssr.h | 44 ++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 include/dt-bindings/clock/r8a7743-cpg-mssr.h
 create mode 100644 include/dt-bindings/clock/r8a7745-cpg-mssr.h

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
