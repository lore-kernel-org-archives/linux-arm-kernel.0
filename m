From: broonie@kernel.org (Mark Brown)
Date: Wed, 20 Sep 2017 12:34:46 +0100
Subject: [PATCH v7 2/8] mfd: wm97xx-core: core support for wm97xx Codec
In-Reply-To: <20170920082443.cqimrbhddum23lof@dell>
References: <20170913193723.16234-1-robert.jarzmik@free.fr>
 <20170913193723.16234-3-robert.jarzmik@free.fr>
 <20170914074146.dnibkvom4yuzejf3@dell>
 <20170914074300.iobuwn2hrmnf6sen@dell>
 <20170914160453.gys3imt4eobckcrq@sirena.org.uk>
 <20170918085236.z6gmgrwvsjvvc4cd@dell>
 <20170919121539.mz2mettkefxf3oer@sirena.co.uk>
 <20170919152253.tvj3hheggrx4lgig@dell>
 <20170919160422.l7lxmfl6yrjnpalb@sirena.co.uk>
 <20170920082443.cqimrbhddum23lof@dell>
Message-ID: <20170920113446.ttwv23riutpp7e5i@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 20, 2017 at 09:24:43AM +0100, Lee Jones wrote:
> On Tue, 19 Sep 2017, Mark Brown wrote:

> > It really helps if we can get the earlier parts of the series moving
> > even if the rest of it's in review still - I know I back off on
> > reviewing things if it looks like their dependencies aren't making
> > progress.

> Just for your FYI, I tend to review my parts then wait for the
> rest of the series to be reviewed, then discuss how the set should be
> handled.

> Holding back on reviewing your parts is not a good idea.  If everyone
> did that we'd end up in a circular Maintainer dependency and nothing
> would ever get reviewed.

I get fed up with having to re-review the same patches over and over and
over again while people work out what's going on with the earlier parts
of the series, that gets very time consuming and is error prone.  If
we're getting churn early on in the series that's causing things to
change then it's better to let that settle down and look properly at the
results than glaze over looking at each minor change as it comes in and
miss other things that get tweaked.  Once the dependencies are stable
then it becomes worthwhile again.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170920/a7bf2923/attachment.sig>
