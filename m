From: biju.das@bp.renesas.com (Biju Das)
Date: Tue, 22 Aug 2017 08:13:19 +0000
Subject: [PATCH  0/3] Add SDHI Support
In-Reply-To: <20170822080258.GF30838@verge.net.au>
References: <1502711389-16040-1-git-send-email-biju.das@bp.renesas.com>
 <20170822080258.GF30838@verge.net.au>
Message-ID: <KL1PR06MB170244954ECB471B0212746FB8840@KL1PR06MB1702.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Simon Horman [mailto:horms at verge.net.au]
> Sent: 22 August 2017 09:03
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: Rob Herring <robh+dt@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Magnus Damm <magnus.damm@gmail.com>;
> Chris Paterson <Chris.Paterson2@renesas.com>; Wolfram Sang
> <wsa+renesas@sang-engineering.com>; devicetree at vger.kernel.org; linux-
> renesas-soc at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 0/3] Add SDHI Support
>
> On Mon, Aug 14, 2017 at 12:49:46PM +0100, Biju Das wrote:
> > This series aims to add SDHI support for r8a7743 SoC.
> >
> > This series has been compiled and tested against renesas-dev tag
> > renesas-devel-20170814-v4.13-rc5.
> >
> > There is no compile time dependencies.It has run time dependency on
> > [PATCH ] mmc: renesas_sdhi: Add r8a7743/5 support.
> > https://patchwork.kernel.org/patch/9898611/
> >
> > Biju Das (3):
> >   ARM: dts: r8a7743: Add SDHI controllers
> >   ARM: dts: iwg20m: Enable SDHI0 controller
> >   ARM: dts: iwg20d-q7: Add SDHI1 support
>
> Thanks, applied for v4.15 with Wolfram's tags.
>
> There was some fuzz when applying the last patch.
> Please check that is is correct once I push today's devel tag to the renesas tree.

Thanks. I will check and let you know if there is any issues.




Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
