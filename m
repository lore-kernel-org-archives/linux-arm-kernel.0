From: broonie@kernel.org (Mark Brown)
Date: Mon, 25 Jan 2016 12:23:47 +0000
Subject: [PATCH 03/15] dmaengine: dw: rename masters to reflect actual
 topology
In-Reply-To: <yw1xk2myli0u.fsf@unicorn.mansr.com>
References: <1453663322-14474-1-git-send-email-mans@mansr.com>
 <1453663322-14474-4-git-send-email-mans@mansr.com>
 <20160124223629.GI6588@sirena.org.uk>
 <yw1xk2myli0u.fsf@unicorn.mansr.com>
Message-ID: <20160125122347.GM6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 24, 2016 at 10:38:57PM +0000, M?ns Rullg?rd wrote:
> Mark Brown <broonie@kernel.org> writes:

> > This is patch 3 of a series but I don't have anything else in the
> > series.  What is going on with the rest of the series - what are the
> > dependencies and so on?

> I give up.  Seriously, this is impossible.  If I don't include everybody
> in the slightest way related to any patch in the series, I get
> complaints that patches are missing.  If I do, the lists reject it all
> due to too many recipients.  What the hell am I supposed to do?

You should normally include at least the subsystem maintainers in at
least the cover letter and cover the dependencies there.  Think about
how this is going to work: if you don't give us any information on
what's going on with dependencies then we can't tell how to handle the
patches - do we need to apply them, only review them or what?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160125/fc040ebe/attachment-0001.sig>
