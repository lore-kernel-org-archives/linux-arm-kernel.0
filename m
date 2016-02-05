From: broonie@kernel.org (Mark Brown)
Date: Fri, 5 Feb 2016 15:32:58 +0000
Subject: [PATCH v2 1/2] regulator: Add coupled regulator
In-Reply-To: <20160205143328.GD31506@lukather>
References: <1452605842-9317-1-git-send-email-maxime.ripard@free-electrons.com>
 <1452605842-9317-2-git-send-email-maxime.ripard@free-electrons.com>
 <20160112143100.GA14628@rob-hp-laptop>
 <20160115085734.GG4581@lukather>
 <20160117000434.GB7774@rob-hp-laptop>
 <20160118162538.GH6588@sirena.org.uk>
 <20160121154649.GE3997@lukather>
 <20160121162802.GL6588@sirena.org.uk>
 <20160205143328.GD31506@lukather>
Message-ID: <20160205153258.GW4455@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 05, 2016 at 03:33:28PM +0100, Maxime Ripard wrote:
> On Thu, Jan 21, 2016 at 04:28:02PM +0000, Mark Brown wrote:
> > On Thu, Jan 21, 2016 at 04:46:49PM +0100, Maxime Ripard wrote:

> > > Anyway, I'm fine with both approaches, just let me know what you
> > > prefer.

> > Without seeing an implementation of the lists it's hard to say.

> Just to make sure we're on the same page: you want to keep the
> regulator, but instead of giving the parent through vinX-supplies
> properties, you want to have a single *-supply property, with a list
> of regulators, right?

Either that or an explicit regulator describing the merge.  Rob wants
the list I think but I really don't care.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160205/d5a0c1d4/attachment.sig>
