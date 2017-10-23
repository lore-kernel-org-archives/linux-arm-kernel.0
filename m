From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 23 Oct 2017 11:11:08 +0000
Subject: [PATCH 3/4] ARM: dts: iwg22d-sodimm-dbhd-ca: Add device tree for
 HDMI DB
In-Reply-To: <20171017080220.ff5brg2jh4womfj2@verge.net.au>
References: <1507899796-7941-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1507899796-7941-4-git-send-email-fabrizio.castro@bp.renesas.com>
 <20171017080220.ff5brg2jh4womfj2@verge.net.au>
Message-ID: <TY1PR06MB0895CE4565980694E481790CC0460@TY1PR06MB0895.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Simon,

>
> On Fri, Oct 13, 2017 at 02:03:15PM +0100, Fabrizio Castro wrote:
> > Add file r8a7745-iwg22d-sodimm-dbhd-ca.dts to provide support for
> > iW-RainboW-G22D with HDMI daughter board plugged in.
> >
> > The interfaces defined in the new .dts file are: scif1, scif5,
> > and hscif2.
> >
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
>
> I wonder if this patch should include a chosen node.

the chosen node gets inherited from file r8a7745-iwg22d-sodimm.dts,
I don't think the HW configuration with the carrier board should behave
any different from the HW configuration without the carrier board.

Thanks,
Fab



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
