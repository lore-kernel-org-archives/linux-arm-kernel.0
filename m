From: linux@rempel-privat.de (Oleksij Rempel)
Date: Thu,  8 Jan 2015 10:16:44 +0100
Subject: [PATCH 0/3] [MERGE REQUEST] DT support for Alphascale asm9260
In-Reply-To: <1733388.SP14pjVoMj@wuerfel>
References: <1733388.SP14pjVoMj@wuerfel>
Message-ID: <1420708607-23052-1-git-send-email-linux@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
this patches provide DT support for Alphascale asm9260 SoC.
As was suggested..., I explicitly ask you to merge them :D

Oleksij Rempel (3):
  ARM: dts: add DT for Alphascale ASM9260 SoC
  ARM: add alphascale,acc.txt bindings documentation
  add Alphascale to vendor-prefixes.txt

 .../devicetree/bindings/clock/alphascale,acc.txt   | 115 +++++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   2 +-
 arch/arm/boot/dts/alphascale-asm9260-devkit.dts    |  13 +++
 arch/arm/boot/dts/alphascale-asm9260.dtsi          |  63 +++++++++++
 5 files changed, 193 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/alphascale,acc.txt
 create mode 100644 arch/arm/boot/dts/alphascale-asm9260-devkit.dts
 create mode 100644 arch/arm/boot/dts/alphascale-asm9260.dtsi

-- 
1.9.1
