From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Oct 2011 22:15:58 +0100
Subject: [GIT PULL] GIC DT binding support
In-Reply-To: <4EA08DD0.1090706@gmail.com>
References: <4E97A601.1020005@gmail.com> <201110201507.38722.arnd@arndb.de>
	<4EA03160.1050304@gmail.com> <201110201812.29202.arnd@arndb.de>
	<4EA055AF.4030207@gmail.com>
	<20111020185612.GD21648@n2100.arm.linux.org.uk>
	<4EA08DD0.1090706@gmail.com>
Message-ID: <20111020211558.GE21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2011 at 04:08:32PM -0500, Rob Herring wrote:
> Understood, but from a git perspective the commit ids have changed.
> While git can deal with trivial re-commits like this, my understanding
> is that should be avoided for upstream merges. Otherwise, I could just
> cherry-pick them and re-commit them in my tree.

It's precisely that need people feel to cherry-pick stuff which is
the need to keep my tree 'unstable' so that I _can_ reorganize it
to permit people to base work off it.

> Ultimately, the people working off of those branches do need them to be
> stable to merge their branches. So are you saying your l2x0 branch
> (91c2ebb90b1890abc648ba9dec5608cbc97e1cb9) is now stable? Can you
> publish it as a branch. iMX6Q is also dependent on it.

Indeed I can - all it takes is someone to tell me what they require
and I can sort it out - and this is especially so as I'm not planning
to do anything further with my git tree after this evening (on the
assumption that the merge window will open immediately after the
kernel summit.)

I already have several 'stable' branches: pm, smp, debug, and now
l2x0.
