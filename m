From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Wed, 30 Mar 2011 18:56:19 -0700
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <AANLkTimS_8BnBz9MSdxYJVL6oreEpH=W61BsyuX2G+Xz@mail.gmail.com>
References: <20110317183048.GW7258@atomide.com>
	<AANLkTimWbb5DWiiCW821H6pRicbk1fS3PYcnGyUMznvM@mail.gmail.com>
	<20110318101512.GA15375@n2100.arm.linux.org.uk>
	<201103301906.42429.arnd@arndb.de>
	<AANLkTim578-kwM14SJd06RW_QiC4WVCmFuG+ASgGC4sq@mail.gmail.com>
	<20110331001502.GB6680@n2100.arm.linux.org.uk>
	<AANLkTinE7EDbV8hrYZWBxgvwOxdPMLoS0Y57PSm04rvM@mail.gmail.com>
	<AANLkTik-BFTzyPLuYVdhCJPocc0wPY0rKvO7BQS4Fg1S@mail.gmail.com>
	<AANLkTikd_JRxmB_OWZqq178=K3bnxhdDqcNbgFNRtTyU@mail.gmail.com>
	<AANLkTimS_8BnBz9MSdxYJVL6oreEpH=W61BsyuX2G+Xz@mail.gmail.com>
Message-ID: <AANLkTimtO7vR2AQvJj1hHMqHCDqtoiJX_eENE9o3dPpV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2011 at 6:44 PM, Bill Gatliff <bgat@billgatliff.com> wrote:
>
> In the meantime, we have to live with the chips that exist and the
> ones coming down the pipe. ?Until ARM and all their licensees start
> consulting us on such matters, we'll just have to find a way to deal
> with what we're given after the fact.

Yes. But:

 (a) we don't have to be stupid and think it's a good design and an
"opportunity" like you do.

and

 (b) the kernel source code doesn't have to be the mess of code that
it is. Those things should be abstracted out somehow (and yes,
devicetree is hopefully one way)

I really don't understand why you seem to be arguing against trying to
fix a real problem, and why you also seem to be arguing that the messy
ARM situation is somehow "good". I find your attitude about the lack
of platform being "good" be to incomprehensibly stupid. There is
absolutely _no_ advantage to anybody from the crazy arm fragmentation.

I know, I know, a lot of companies make money supporting the whole
crazy mess. I guess that can make people confused and think that being
messy is good, and could be seen as an advantage.

But most embedded companies seem to have realized that they should
move up the stack, rather than worry about some crazy GPIO or stupid
driver details.

                Linus
