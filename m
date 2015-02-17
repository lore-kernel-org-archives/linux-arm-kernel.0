From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 17 Feb 2015 14:31:53 +0100
Subject: [PATCH 0/2] ARM: shmobile: emev2 dts: Add pinmux support
Message-ID: <1424179915-17417-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	Hi Simon, Magnus,

Here are the two remaining patches from Niklas S?derlund to add
pinmux support for EMMA Mobile EV2. The patches for the actual pinctrl
driver have already landed in Linus' tree.

Thanks for applying!

Niklas S?derlund (2):
  ARM: shmobile: emev2 dtsi: Add PFC information
  ARM: shmobile: emev2-kzm9d dts: Add PFC information for uart1

 arch/arm/boot/dts/emev2-kzm9d.dts | 13 +++++++++++++
 arch/arm/boot/dts/emev2.dtsi      | 10 ++++++++++
 2 files changed, 23 insertions(+)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
