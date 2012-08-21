From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 21 Aug 2012 17:52:07 +0100
Subject: [PATCH 5/8] mfd: Provide the PRCMU with its own IRQ domain
In-Reply-To: <20120821120243.GF26899@gmail.com>
References: <20120820121055.GA26991@opensource.wolfsonmicro.com>
 <20120820125531.GA20242@gmail.com>
 <20120820162923.GF26991@opensource.wolfsonmicro.com>
 <20120820164949.GB22749@gmail.com>
 <20120820175155.GH26991@opensource.wolfsonmicro.com>
 <20120821085618.GA26899@gmail.com>
 <20120821095026.GU26991@opensource.wolfsonmicro.com>
 <20120821105413.GD26899@gmail.com>
 <20120821110329.GA7995@opensource.wolfsonmicro.com>
 <20120821120243.GF26899@gmail.com>
Message-ID: <20120821165207.GX7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 21, 2012 at 01:02:46PM +0100, Lee Jones wrote:
> On Tue, Aug 21, 2012 at 12:03:29PM +0100, Mark Brown wrote:

> > > another way to get hold of the domain, because the only way to obtain
> > > it without having direct access is via a device node.

> > This doesn't actually hold.

> Okay, besides irq_find_host(struct device_node *np), how else can you fetch
> a domain from the irqdomain?

I'm not sure I can parse the above, sorry - I'm not sure I can
distinguish "domain" and "irqdomain".

> What have you done already? 

Implemented a patch for this which I've now tested a bit and will
probably post in the next hour or so.

> Why make suggestions if you're just going to do the work yourself?

I made the suggestion then later on realised that this was actively
going to break things I care about so I actually need it fixing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120821/7a73e216/attachment.sig>
