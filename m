From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 14 Jul 2012 23:34:54 +0200
Subject: linux-next: manual merge of the arm-soc tree with the
 i2c-embedded tree
In-Reply-To: <20120712131231.GH2194@pengutronix.de>
References: <20120710164130.f38e4d1673f925ddb13914c9@canb.auug.org.au>
 <20120712131231.GH2194@pengutronix.de>
Message-ID: <CACRpkdboeF_G=sTPeSyuZ6KGLCmGSKx_NS=6Rim6HkR2f9=AAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2012 at 3:12 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:

> Arnd, since you committed the patches, can you please comment? I'd
> prefer to drop this DT conversion for now, otherwise we might have to
> support this possibly rushed bindings forever? LinusW, what do you
> think?

Well I think I ACKed that from the point of view that it will work as
expected with ux500 with these bindings. What is best from the I2C
subsystem point of view is another question ...

Overall I think we have this general problem with a lot of DT
conversion happening right now: the tempo is set very high and
all chip vendors want DT support RealQuickNowPreferrablyYesterday
and that makes it hard for subsystem maintainers to hold back,
and I also fear vendor-specific properties are overused for this
reason.

And about the perpetual nature of device tree bindings it
appears to me that the modus operandi right now is to not
regard any of these as written in stone until they are removed
from the kernel tree. We have plenty of drivers patching
trees and drivers in one for the moment.

Yours,
Linus Walleij
