From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Thu, 10 Aug 2017 13:49:05 +0000
Subject: [PATCH 2/2] ARM: dts: r8a7743: Add IIC cores to dtsi
In-Reply-To: <20170810112411.GA4380@katana>
References: <1502196418-31341-1-git-send-email-biju.das@bp.renesas.com>
 <12d923ba-184c-ef59-f27b-41a7592a5f93@cogentembedded.com>
 <20170810080121.GE16647@verge.net.au> <20170810112411.GA4380@katana>
Message-ID: <TY1PR06MB0702EA22AFE7D8145BF623A6B7880@TY1PR06MB0702.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> From: Wolfram Sang [mailto:wsa at the-dreams.de]
> Sent: 10 August 2017 12:24
> 
> 
> > > >+		i2c6: i2c at e60b0000 {
> > >
> > >    I'd use iic0 as the label.
> >
> > I have no preference here other than that we try to be consistent in
> > DT for different R-Car SoCs. Wolfram, do you have an opinion on this?
> 
> Back then, for M2-W, I decided to go with the schematics/datasheets.
> And those mentioned i2c6 rather than iic0. For that reason, the comment

The M2 schematics still use i2c6, and for consistency I'd vote to use the same with RZ/G1M.

> 
> "/* The memory map in the User's Manual maps the cores to bus numbers */"
> 
> exists in r8a7791.dtsi. Dunno the manual of this SoC here.

The manual for r8a7743 uses the same terminology as the r8a7791 manuals.

Kind regards, Chris
