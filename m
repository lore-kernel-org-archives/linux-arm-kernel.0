From: broonie@kernel.org (Mark Brown)
Date: Fri, 29 Jul 2016 13:11:23 +0100
Subject: SPI: performance regression when using the common message
 queuing infrastructure
In-Reply-To: <41cb8a2a-7138-d2c0-e668-6c03add1882e@atmel.com>
References: <577CD464.6050506@atmel.com> <577CD767.2080309@ti.com>
 <577E0EF3.6000308@atmel.com> <57959ADD.40700@denx.de>
 <41cb8a2a-7138-d2c0-e668-6c03add1882e@atmel.com>
Message-ID: <20160729121123.GD10376@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 29, 2016 at 11:33:00AM +0200, Cyrille Pitchen wrote:

> We talked about moving back to a tasklet implementation but nothing was done
> yet so nothing new for now, sorry.
> Also, I will be out of office for the next 3 weeks: I will be back on August,
> 22th.

To repeat what I said before the thing to do here is to improve the
performance of the core implementation rather than just open coding
something.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160729/05ddab58/attachment.sig>
