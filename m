From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 17 Dec 2013 14:02:32 +0900
Subject: [PATCH 00/04 v2] ARM: shmobile: r7s72100 and Genmai GPIO / PINCTRL V2
Message-ID: <20131217050232.727.9552.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: r7s72100 and Genmai GPIO / PINCTRL V2

[PATCH 01/04] ARM: shmobile: r7s72100 GPIO and PINCTRL device nodes
[PATCH 02/04] ARM: shmobile: Genmai SCIF2 PINCTRL configuration
[PATCH 03/04] ARM: shmobile: Genmai LED1 and LED2 support
[PATCH 04/04 v2] ARM: shmobile: Genmai I2C-over-GPIO support

Add various device nodes to the r7s72100 SoC and the Genmai board,
nothing special just basic support for LEDs and I2C-over-GPIO.

Changes since V1:
 - 2/4 and 3/4 now includes acks, thanks Laurent!
 - 4/4 has been updated, thanks to Sergei and Wolfram!

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-v3.13-rc3-20131214v2
 [PATCH v3] gpio: Renesas RZ GPIO driver V3
 [PATCH 00/05 v2] pinctrl: sh-pfc: r7s72100 support V2

 arch/arm/boot/dts/r7s72100-genmai-reference.dts |   41 +++++-
 arch/arm/boot/dts/r7s72100.dtsi                 |  154 +++++++++++++++++++++++
 2 files changed, 194 insertions(+), 1 deletion(-)
