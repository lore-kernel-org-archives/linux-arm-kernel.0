From: stefanc@marvell.com (Stefan Chulski)
Date: Mon, 19 Mar 2018 13:03:04 +0000
Subject: [EXT] Re: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR
 interface to use in-band negotiation
In-Reply-To: <20180319125953.GD19795@lunn.ch>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-3-antoine.tenart@bootlin.com>
 <20180316155307.GQ9418@n2100.armlinux.org.uk> <20180319085252.GF4519@kwain>
 <20180319111205.GB2743@n2100.armlinux.org.uk> <20180319125227.GI4519@kwain>
 <20180319125953.GD19795@lunn.ch>
Message-ID: <54e290a192734831b5db22191f056a81@IL-EXCH01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Andrew Lunn [mailto:andrew at lunn.ch]
> Sent: Monday, March 19, 2018 3:00 PM
> To: Antoine Tenart <antoine.tenart@bootlin.com>
> Cc: Russell King - ARM Linux <linux@armlinux.org.uk>;
> davem at davemloft.net; kishon at ti.com; gregory.clement at bootlin.com;
> jason at lakedaemon.net; sebastian.hesselbarth at gmail.com;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org;
> thomas.petazzoni at bootlin.com; maxime.chevallier at bootlin.com;
> miquel.raynal at bootlin.com; Nadav Haklai <nadavh@marvell.com>; Stefan
> Chulski <stefanc@marvell.com>; Yan Markman <ymarkman@marvell.com>;
> mw at semihalf.com; linux-arm-kernel at lists.infradead.org
> Subject: [EXT] Re: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR
> interface to use in-band negotiation
> 
> External Email
> 
> ----------------------------------------------------------------------
> Hi Antoine
> 
> > You guessed right, that's exactly my use case. The DB boards (7k and
> > 8k) have 10G interfaces without PHYs.
> 
> If they don't have PHYs, how are the connected to the outside world?
> 
>    Andrew

By external SFP or direct attached cable.

Stefan.
