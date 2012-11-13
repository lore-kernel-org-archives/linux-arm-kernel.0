From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 13 Nov 2012 19:01:48 +0900
Subject: [GIT PULL v3] Renesas ARM-based SoC boards for v3.8 #2
In-Reply-To: <201211130848.03800.arnd@arndb.de>
References: <1352446306-19945-1-git-send-email-horms@verge.net.au>
 <201211122111.03440.arnd@arndb.de>
 <20121113053651.GB18224@opensource.wolfsonmicro.com>
 <201211130848.03800.arnd@arndb.de>
Message-ID: <20121113100144.GX18224@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2012 at 08:48:03AM +0000, Arnd Bergmann wrote:
> On Tuesday 13 November 2012, Mark Brown wrote:

> > Please never pull anything from me unless there's a signed tag for it,
> > anything else I won't know about and may be rebased or vanish or
> > something.

> Ok, thanks for the reminder. Do you have a signed tag containing ab6f6d8521?

Nope, your e-mail was the first I'd heard of the cross-merge.  I guess I
could create one if this is going to get redone for some reason...

> > > I have taken Mark on Cc to let him know about the dependency now, and I've
> > > merged ab6f6d85210c4d0265cf48e9958c04e08595055a (which has only shmobile
> > > specific ASoC patches) into the next/boards2 branch before merging your
> > > branch. This is still not perfect because it breaks bisection, but it's
> > > the best I could do aside from forcing you do do another round-trip.

> > What's the bisection problem?

> I merged ab6f6d8521 first, and then Simon's branch, which means that the
> linear (first-parent) history is ok, but bisecting the entire state of
> the tree may end up in a commit in his branch in a state before it was
> merged into mine, where it doesn't contain the patches it depends on,
> and as Simon mentioned in his pull request, that will cause a build
> failure.

Oh, I'd missed the fact that this wasn't coming in via a merge into
Simon's tree.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121113/498f1a12/attachment.sig>
