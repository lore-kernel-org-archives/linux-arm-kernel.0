From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri, 26 Jan 2018 16:16:34 +0000
Subject: [RFC v2 01/37] ARM: shmobile: Add watchdog support
In-Reply-To: <1516982937-29245-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <TY1PR06MB08950BD28BEC28D55C6D80EDC0E00@TY1PR06MB0895.apcprd06.prod.outlook.com>
 <1516982937-29245-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <TY1PR06MB089517B9B153473B3F411B96C0E00@TY1PR06MB0895.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Geert,


>> Since shmobile_boot_vector has become bigger, "reg" property of nodes
>> compatible with "renesas,smp-sram" now need to be set to "<0 0x64>".

> This breaks backwards compatibility with old DTs declaring a too small
> smp-sram area. If the area is too small, you should fallback to the old and
> smaller code.

would the v2s for patches 01/37 and 23/37 be ok with you to take care of that issue?

Thanks,
Fabrizio



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
