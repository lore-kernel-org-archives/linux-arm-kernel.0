From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 6 May 2015 08:59:28 +0200
Subject: How to encode being an I2C slave in DT?
In-Reply-To: <20150505105513.GA1841@katana>
References: <1427745615-5428-1-git-send-email-danindrey@mail.ru>
 <20150403194635.GC2016@katana> <1549160.njMIY2NVTi@fb07-iapwap2>
 <20150505105513.GA1841@katana>
Message-ID: <20150506065928.GP25193@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, May 05, 2015 at 12:55:13PM +0200, Wolfram Sang wrote:
> So what about adding a new property "i2c-slave-reg"? This does not only
> prevent the confusion above, but also makes it very clear that this node
> is an I2C slave without the need to encode that somehow in the
> compatible property (although it probably should be described there as
> well, still).
I admit I didn't follow the discussions referenced in the footnotes, but
I wonder if the slave part should be added to the device tree at all.
AFAICT it could (and so should) be completely userspace-defined which
slave driver is used on which address. I imagine that for most
controllers the bus addresses to use can be chosen more or less freely.
So what am I missing?

> > I hope with this post I can join the different discussions somehow so we are 
> > able to find a common sense which is acceptable for all.
> 
> Thanks for doing this! I changed the subject to maybe raise interest a
> bit more.
that worked fine :-)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
