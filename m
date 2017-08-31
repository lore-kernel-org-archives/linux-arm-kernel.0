From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Thu, 31 Aug 2017 09:32:25 +0000
Subject: [PATCH ] ARM: dts: iwg22d-sodimm: Add Ethernet AVB support
In-Reply-To: <KL1PR06MB170280A3D466C9B35AF73939B89D0@KL1PR06MB1702.apcprd06.prod.outlook.com>
References: <1504106234-41450-1-git-send-email-biju.das@bp.renesas.com>
 <20170831084534.GF29946@verge.net.au>
 <KL1PR06MB170280A3D466C9B35AF73939B89D0@KL1PR06MB1702.apcprd06.prod.outlook.com>
Message-ID: <TY1PR06MB07029D315FC6EE500D1EEA55B79D0@TY1PR06MB0702.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> From: Biju Das
> Sent: 31 August 2017 10:24
> 
> > From: Simon Horman [mailto:horms at verge.net.au]
> > Sent: 31 August 2017 09:46

<snip>

> > > +	phy3: ethernet-phy at 3 {
> > > +	/*
> > > +	 * On some older versions of the platform (before R4.0) the phy
> > address
> > > +	 * may be 1 or 3. The address is fixed to 3 for R4.0 onwards.
> > > +	 */
> > > +		reg = <3>;
> > > +		micrel,led-mode = <1>;
> >
> > Does the phy have an interrupt?
> 
> The current board doesn't support interrupt . But there is a plan to support this
> in future board variants through (GPIO3_28).

Actually, the plan has recently changed and at the moment interrupt support will not be added in the production version of the board.

If in the end the plan changes again and the actual hardware does add interrupt support we'll submit a new patch accordingly.

Kind regards, Chris
