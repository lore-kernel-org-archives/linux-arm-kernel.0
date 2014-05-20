From: broonie@kernel.org (Mark Brown)
Date: Tue, 20 May 2014 20:00:55 +0100
Subject: [PATCH v2 2/4] mfd: bcm590xx: add support for secondary I2C
 slave address
In-Reply-To: <20140520161131.GB32025@lee--X1>
References: <1398295293-11033-1-git-send-email-mporter@linaro.org>
 <1398295293-11033-3-git-send-email-mporter@linaro.org>
 <20140428115627.GY21279@lee--X1> <20140428140910.GB7719@beef>
 <20140520161131.GB32025@lee--X1>
Message-ID: <20140520190055.GQ12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 05:11:31PM +0100, Lee Jones wrote:

> > > >  drivers/mfd/bcm590xx.c       | 60 +++++++++++++++++++++++++++++++++-----------
> > > >  include/linux/mfd/bcm590xx.h |  9 ++++---
> > > >  2 files changed, 52 insertions(+), 17 deletions(-)

> > There's cross-deps so the regulator driver will need to go with it.
> > Mark mentioned earlier in the thread that he wanted to merge through
> > the regulator tree though.

> Still nothing.

> Mark,
>   Can I apply this set and supply you with a pull-request?

Can someone please send me whatever it is you want me to look at, the
above diffstat doesn't look relevant.  Given the frequency of respins
I'm not always paying a huge amount of attention to MFD serieses which
look like they're going to be resent.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140520/4133fe63/attachment.sig>
