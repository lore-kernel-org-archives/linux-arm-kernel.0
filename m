From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Fri, 7 May 2010 11:13:57 +0200
Subject: [PATCH 0/7] DMAENGINE: fixes and PrimeCells
In-Reply-To: <1272848060-28049-1-git-send-email-linus.walleij@stericsson.com>
References: <1272848060-28049-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <i2t63386a3d1005070213u2ad32613w694be1ecbeb46856@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dan is this patch set OK?

Sorry if you're busy, just need to check...

Patches 1 thru 4 should be uncontroversial, only affects
our ST-Ericsson platforms and have been thorougly reviewed.

As posted elsewhere this is tested on an ARM reference
design now as well, which IMHO would make it OK to apply
also the PL011 patch, nr 5.

(OK Russell?)

Nr 6 and 7 depend on changes in Russells -next branch
so unless you want to bring in the ARM next to your tree
as well, you can wait with these.

Yours,
Linus Walleij
