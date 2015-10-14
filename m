From: broonie@kernel.org (Mark Brown)
Date: Wed, 14 Oct 2015 10:59:51 +0100
Subject: [PATCH] mutex: make mutex_lock_nested an inline function
In-Reply-To: <20151014090815.GS17308@twins.programming.kicks-ass.net>
References: <11282238.AHmyWliPRj@wuerfel>
 <20151014082050.GQ17308@twins.programming.kicks-ass.net>
 <20151014083707.GR11639@twins.programming.kicks-ass.net>
 <11240940.NHO2vFoJOz@wuerfel>
 <20151014090815.GS17308@twins.programming.kicks-ass.net>
Message-ID: <20151014095950.GQ14956@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2015 at 11:08:15AM +0200, Peter Zijlstra wrote:
> On Wed, Oct 14, 2015 at 11:00:20AM +0200, Arnd Bergmann wrote:
> > On Wednesday 14 October 2015 10:37:07 Peter Zijlstra wrote:

> > but apparently this is work-in-progress and the plan is to use it
> > in 4.4 when the rest of the currently-under-review patches are merged.

> And here I thought we had a fairly strong rule that we should not merge
> unused code :/

The revisions are very minor (and are sitting in my inbox for me to
look at just now), and keeping things out of tree just makes it more
difficult to get them merged - it's one thing if things are getting in
the way for a long time or have a high cost but that's not the case
here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151014/e475a529/attachment.sig>
