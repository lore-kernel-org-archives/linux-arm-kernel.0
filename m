From: michel.pollet@bp.renesas.com (Michel Pollet)
Date: Wed, 28 Mar 2018 08:12:50 +0000
Subject: arm/arm64: smp_spin_table.c for arm32?
Message-ID: <OSBPR01MB2054DFD1BEECD87186E29E51D2A30@OSBPR01MB2054.jpnprd01.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

I'm currently adapting a port from a machine-file based approach to driver based, and I
would have a need for arch/arm64/kernel/smp_spin_table.c -- it's *exactly* my use
case, but for arm32.
So what would be my options here?

1) Make myself a custom driver and ignore this one...
2) Fully duplicate smp_spin_table.c in arch/arm/kernel...
3) .... something else involving a shared bit of code?

I obviously would prefer 3), however, I don't see any obvious way of 'sharing' anything
between these two arch...
Any suggestion greatly appreciated!

Regards,
Michel




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
