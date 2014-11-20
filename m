From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 20 Nov 2014 10:43:21 +0100
Subject: [PATCH RESEND v2 0/4] hwrng: atmel: add DT support
Message-ID: <cover.1416475860.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the patch series that Boris sent yesterday. I've just collected
"Acked-by" tags and resend it with updated cover letter.

This series adds DT support for the TRNG (True Random Generator) block and adds
missing trng nodes to at91sam9g45 dtsi files.

Herbert,
As you said that you can take this series, here is the latest vertion ready for you to
pick it up. Thanks for your help.

Bye,

Boris Brezillon (4):
  hwrng: atmel: use clk_prepapre_enable/_disable_unprepare
  hwrng: atmel: add DT support
  hwrng: atmel: Add TRNG DT binding doc
  ARM: at91/dt: add trng node to at91sam9g45

 Documentation/devicetree/bindings/hwrng/atmel-trng.txt | 16 ++++++++++++++++
 arch/arm/boot/dts/at91sam9g45.dtsi                     |  7 +++++++
 drivers/char/hw_random/Kconfig                         |  2 +-
 drivers/char/hw_random/atmel-rng.c                     | 15 +++++++++++----
 4 files changed, 35 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwrng/atmel-trng.txt

-- 
2.1.3
