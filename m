From: geert+renesas@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 24 Dec 2013 12:56:44 +0100
Subject: [PATCH 0/6] Preliminary SoC and board integration for RSPI on RZ/A1H
Message-ID: <1387886210-3634-1-git-send-email-geert+renesas@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series contains preliminary support to integrate Renesas RSPI on
the RZ/A1H aka R7S72100 SoC, and the Genmai development board.

Note that the prosed DT bindings also talk about QSPI on the R8A779x, as
those SoC use the same driver. The actual driver doesn't use DT yet, but
conversion to DT is planned.

The series is based on renesas-devel-v3.13-rc5-20131223, with Magnus'
pinctrl, Wolfram's riic, and Simon's gether work applied on top.
It hasn't received much testing, so please don't apply yet.

    [1/6] pinctrl: sh-pfc: r7s72100: Add RSPI support
    [2/6] ARM: shmobile: r7s72100: Add RSPI clocks
    [3/6] ARM: shmobile: r7s72100: Add RSPI resources
    [4/6] [RFC] Documentation: dt: Add Renesas RSPI/QSPI bindings
    [5/6] [RFC] ARM: shmobile: r7s72100 dtsi: Add RSPI nodes
    [6/6] [RFC] arm: shmobile: genmai reference: Add RSPI nodes

Thanks for your comments, and Merry Christmas!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
