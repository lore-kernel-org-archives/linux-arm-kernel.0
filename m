From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 3 Apr 2012 07:41:15 +0000
Subject: [PATCH 1/3] PATA host controller driver for ep93xx
In-Reply-To: <4F7A5781.3000507@gmail.com>
References: <4F7418E7.4060500@metasoft.pl> <4F795AD1.4070101@metasoft.pl>
 <4F7A5781.3000507@gmail.com>
Message-ID: <201204030741.16596.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 03 April 2012, Ryan Mallon wrote:
> On 02/04/12 17:52, Rafal Prylowski wrote:
>
> > Yes, I already prepared a version of the driver in which IDE register
> > addresses are coded as enums instead of using ata_port->ioaddr structure. 
> > I will post updated version, when I get feedback from Ryan if enums
> > or defines are preferred.
> 
> I would prefer defines, simply because it looks odd having an enum which
> has multiple names defined to the same value, and most drivers tend to
> use defines rather than enums for registers. It's not a big deal though,
> and certainly not a show stopper.

I tend to prefer enums, but I agree that it's a minor issue and I generally
don't even mention it in reviews.

	Arnd
