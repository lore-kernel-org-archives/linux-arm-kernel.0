From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 16 Jul 2012 12:17:06 +0200
Subject: linux-next: manual merge of the arm-soc tree with the
 i2c-embedded tree
In-Reply-To: <CACRpkdboeF_G=sTPeSyuZ6KGLCmGSKx_NS=6Rim6HkR2f9=AAQ@mail.gmail.com>
References: <20120710164130.f38e4d1673f925ddb13914c9@canb.auug.org.au>
 <20120712131231.GH2194@pengutronix.de>
 <CACRpkdboeF_G=sTPeSyuZ6KGLCmGSKx_NS=6Rim6HkR2f9=AAQ@mail.gmail.com>
Message-ID: <20120716101706.GB17435@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Well I think I ACKed that from the point of view that it will work as
> expected with ux500 with these bindings. What is best from the I2C
> subsystem point of view is another question ...

Okay, thanks for clarifying.

> Overall I think we have this general problem with a lot of DT
> conversion happening right now: the tempo is set very high and
> all chip vendors want DT support RealQuickNowPreferrablyYesterday
> and that makes it hard for subsystem maintainers to hold back,
> and I also fear vendor-specific properties are overused for this
> reason.

Word.

> And about the perpetual nature of device tree bindings it
> appears to me that the modus operandi right now is to not
> regard any of these as written in stone until they are removed
> from the kernel tree. We have plenty of drivers patching
> trees and drivers in one for the moment.

I don't get this one. Yes, they are of perpetual nature, so how could we
remove them from the kernel tree?

What I am afraid of is: tentative solutions tend to stay, because the
need for a proper solution is reduced. Yet, finding proper generic
bindings might take some time which doesn't meet the high pressure
around DT at the moment.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120716/b629a373/attachment-0001.sig>
