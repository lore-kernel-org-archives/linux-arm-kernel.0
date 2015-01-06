From: linux@rempel-privat.de (Oleksij Rempel)
Date: Tue, 06 Jan 2015 12:06:36 +0100
Subject: [PATCH 0/4] suport for Alphascale ASM9260, part 4
In-Reply-To: <1417193657-31602-1-git-send-email-linux@rempel-privat.de>
References: <201411281509.19170.arnd@arndb.de>
 <1417193657-31602-1-git-send-email-linux@rempel-privat.de>
Message-ID: <54ABC1BC.6020801@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

any updates here?

Am 28.11.2014 um 17:54 schrieb Oleksij Rempel:
> Oleksij Rempel (4):
>   ARM: clocksource: add asm9260_timer driver
>   ARM: dts: add DT for Alphascale ASM9260 SoC
>   ARM: add alphascale,acc.txt bindings documentation
>   add Alphascale to vendor-prefixes.txt
> 
>  .../devicetree/bindings/clock/alphascale,acc.txt   | 115 +++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  arch/arm/boot/dts/Makefile                         |   2 +
>  arch/arm/boot/dts/alphascale-asm9260-devkit.dts    |  13 ++
>  arch/arm/boot/dts/alphascale-asm9260.dtsi          |  63 ++++++
>  drivers/clocksource/Kconfig                        |   9 +
>  drivers/clocksource/Makefile                       |   1 +
>  drivers/clocksource/asm9260_timer.c                | 220 +++++++++++++++++++++
>  8 files changed, 424 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/alphascale,acc.txt
>  create mode 100644 arch/arm/boot/dts/alphascale-asm9260-devkit.dts
>  create mode 100644 arch/arm/boot/dts/alphascale-asm9260.dtsi
>  create mode 100644 drivers/clocksource/asm9260_timer.c
> 


-- 
Regards,
Oleksij

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 213 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/a7b7bcae/attachment.sig>
