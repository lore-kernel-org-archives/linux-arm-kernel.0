From: broonie@kernel.org (Mark Brown)
Date: Mon, 10 Sep 2018 16:19:26 +0100
Subject: [PATCH v9 3/6] kernel/reboot.c: export pm_power_off_prepare
In-Reply-To: <20180909020021.GA18838@dragon>
References: <20180802103425.3053-1-o.rempel@pengutronix.de>
 <20180802103425.3053-4-o.rempel@pengutronix.de>
 <20180802104443.GH9117@sirena.org.uk>
 <94d48ecb-7302-c7ed-e815-730be0426a04@pengutronix.de>
 <20180802113552.GJ9117@sirena.org.uk>
 <20180827014815.GD29208@dragon>
 <20180906101516.GA5360@sirena.org.uk>
 <20180909020021.GA18838@dragon>
Message-ID: <20180910151926.GA10889@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 09, 2018 at 10:00:23AM +0800, Shawn Guo wrote:
> On Thu, Sep 06, 2018 at 11:15:17AM +0100, Mark Brown wrote:

> > I was expecting to get a pull request with the precursor patches in it -
> > the regulator driver seems to get a moderate amount of development so
> > there's a reasonable risk of conflicts.

> What about you create a stable topic branch for regulator patches and I
> pull it into IMX tree?

Sure, I can send a pull request back but the first two patches in the
series are ARM ones - are you OK with me just applying them and sending
them in the pull request or do you want to apply them first?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180910/a549cbdc/attachment.sig>
