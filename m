From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 30 Jan 2013 17:43:00 -0500
Subject: [PATCH v2 1/2] ARM: kirkwood: Ensure that
 kirkwood_ge0[01]_init() finds its clock
In-Reply-To: <51083580.1010900@gmail.com>
References: <51053761.1020009@gmail.com>
 <20130127144610.GW1758@titan.lakedaemon.net>
 <51053F81.6020904@gmail.com>
 <20130127152431.GX1758@titan.lakedaemon.net>
 <20130128223148.GA10275@schnuecks.de>
 <20130129004824.GB7717@titan.lakedaemon.net>
 <20130129194243.GA30831@schnuecks.de> <51082C4E.5050903@gmail.com>
 <20130129203221.GG7717@titan.lakedaemon.net>
 <51083580.1010900@gmail.com>
Message-ID: <20130130224300.GU7717@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On 01/29/2013 09:32 PM, Jason Cooper wrote:
> >On Tue, Jan 29, 2013 at 09:08:46PM +0100, Sebastian Hesselbarth wrote:
> >>Leaves Issue 3, gbe forgets about its MAC address when gated or powered
> >>down. That should be done with local-mac-address passed by DT enabled
> >>u-boot or any other (dirty) ATAG hack ;)
> >
> >A patch to mv643xx_eth to pull this from DT should solve this.

Somewhere, Jason Gunthorpe shared his patch to do this.  I'll poke
around for it and try to get it merged in.

thx,

Jason.
