From: David.Laight@ACULAB.COM (David Laight)
Date: Thu, 8 Nov 2018 14:19:27 +0000
Subject: [PATCH] usb: gadget: fix spelling mistakeis "[En]queing" ->
 "[En]queuing"
In-Reply-To: <1541642122.1498358.1569514624.6EA70C69@webmail.messagingengine.com>
References: <20180929114313.10557-1-colin.king@canonical.com>
 <1541642122.1498358.1569514624.6EA70C69@webmail.messagingengine.com>
Message-ID: <66d0fa13f6b6409bbc6b080ae58273ff@AcuMS.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Jeffery
> Sent: 08 November 2018 01:55
> > -		EPDBG(ep,"Enqueing request on wrong or disabled EP\n");
> > +		EPDBG(ep, "Enqueuing request on wrong or disabled EP\n");

Shouldn't it be Enqueueing ?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
