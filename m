From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 16 Jul 2012 15:00:15 +0200
Subject: linux-next: manual merge of the arm-soc tree with the
 i2c-embedded tree
In-Reply-To: <5003FB7C.4030509@linaro.org>
References: <20120710164130.f38e4d1673f925ddb13914c9@canb.auug.org.au>
 <20120712131231.GH2194@pengutronix.de>
 <CACRpkdboeF_G=sTPeSyuZ6KGLCmGSKx_NS=6Rim6HkR2f9=AAQ@mail.gmail.com>
 <20120716101706.GB17435@pengutronix.de>
 <5003FB7C.4030509@linaro.org>
Message-ID: <20120716130015.GF17435@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >What I am afraid of is: tentative solutions tend to stay, because the
> >need for a proper solution is reduced. Yet, finding proper generic
> >bindings might take some time which doesn't meet the high pressure
> >around DT at the moment.
> 
> I agree with what you say to some extent, but I believe that it is
> more important to have a working solution now than to ensure that
> each bindings are as unique as possible. After any suggestion of
> consolidation, a move from vendor specific to generically defined
> Device Tree bindings is trivial. Especially in the current stage
> where adaptions and definitions are still fluid.

See my response to Linus. I do understand your view and where it comes
from. As a maintainer, I have other priorities. No offence involved,
it needs some settlement.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120716/07a9f7c0/attachment.sig>
