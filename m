From: uwe@kleine-koenig.org (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 5 Nov 2016 22:27:49 +0100
Subject: [PATCH RFC] ARM: dts: add support for Turris Omnia
In-Reply-To: <20161105212326.GC1216@lunn.ch>
References: <20161105203841.9661-1-uwe@kleine-koenig.org>
 <20161105212326.GC1216@lunn.ch>
Message-ID: <20161105212748.vtdprlxxismy5xmk@perseus.defre.kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andrew,

On Sat, Nov 05, 2016 at 10:23:26PM +0100, Andrew Lunn wrote:
> > Still missing is support for the switch.
> 
> Is it a Marvell Switch? armada-370-rd.dts would be a good start for
> the old binding? vf610-zii-dev-rev-b.dts uses the new binding.

Yeah, a 88E6176. I already try to understand vf610-zii-dev-rev-b.dts. Do
you know if this driver works for the 88E6176?

> > SFP is untested as is UART1.
> 
> UART would be unusual. They are normally i2c.

I wanted to say: SFP is untested, and UART1 is untested too. Yes, SFP is
connected via i2c.

> > Do I need to "register" turris in vendor-prefixes.txt for that?
> 
> Yes please.

OK, will wait for Martin to comment what we want there. cznic or turris.

Thanks
Uwe
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161105/7d3c829b/attachment.sig>
