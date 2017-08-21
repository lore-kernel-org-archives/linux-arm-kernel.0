From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 21 Aug 2017 09:47:36 +0000
Subject: [PATCH ] mmc: renesas_sdhi: Add r8a7743/5 support
In-Reply-To: <20170821082523.GA2418@katana>
References: <1502710766-44361-1-git-send-email-biju.das@bp.renesas.com>
 <20170821082523.GA2418@katana>
Message-ID: <KL1PR06MB1702E32A5BF249BC5D5FB767B8870@KL1PR06MB1702.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Wolfram Sang [mailto:wsa at the-dreams.de]
> Sent: 21 August 2017 09:25
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>; Rob Herring <robh+dt@kernel.org>;
> Mark Rutland <mark.rutland@arm.com>; Simon Horman
> <horms@verge.net.au>; Magnus Damm <magnus.damm@gmail.com>; Chris
> Paterson <Chris.Paterson2@renesas.com>; Wolfram Sang
> <wsa+renesas@sang-engineering.com>; devicetree at vger.kernel.org; linux-
> renesas-soc at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> mmc at vger.kernel.org
> Subject: Re: [PATCH ] mmc: renesas_sdhi: Add r8a7743/5 support
>
>
> >    Below is the number clocks for each supported SoC:
> > -   1: SH73A0, R8A73A4, R8A7740, R8A7778, R8A7779, R8A7790
> > -      R8A7791, R8A7792, R8A7793, R8A7794, R8A7795, R8A7796
> > +   1: SH73A0, R8A73A4, R8A7740, R8A7743, R8A7745, R8A7778,
> R8A7779,
> > +      R8A7790, R8A7791, R8A7792, R8A7793, R8A7794, R8A7795,
> R8A7796
> >     2: R7S72100
>
> Hmm, maybe we should convert this to only listing SoCs with two clocks?
> That will be easier to maintaine since the majority seems to have one.

Ok. I will send v2 with the suggested  changes.





Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
