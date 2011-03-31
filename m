From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Wed, 30 Mar 2011 17:55:45 -0700
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <20110331001502.GB6680@n2100.arm.linux.org.uk>
References: <20110317183048.GW7258@atomide.com>
	<AANLkTimWbb5DWiiCW821H6pRicbk1fS3PYcnGyUMznvM@mail.gmail.com>
	<20110318101512.GA15375@n2100.arm.linux.org.uk>
	<201103301906.42429.arnd@arndb.de>
	<AANLkTim578-kwM14SJd06RW_QiC4WVCmFuG+ASgGC4sq@mail.gmail.com>
	<20110331001502.GB6680@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinE7EDbV8hrYZWBxgvwOxdPMLoS0Y57PSm04rvM@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2011 at 5:15 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> In this merge window, I deleted at least 6000 lines from arch/arm, and
> by quoting diffstat percentages, you're using that against the ARM
> community. ?Why did I bother (that's not a question).

Umm. The actual stats are still:

 1349 files changed, 62230 insertions(+), 33993 deletions(-)

which is sad. And the end result speaks for itself: this is lines per
architecture:

  ...
  124022 total arch/sh
  124418 total arch/sparc
  181997 total arch/m68k
  246717 total arch/mips
  254785 total arch/x86
  370912 total arch/powerpc
  732732 total arch/arm

notice how ARM ends up being in a class of its own. This is a PROBLEM.

And ARM fanbois can say "oh, but arm is special" all they want, but
they need to realize that the lack of common platform for ARM is a
real major issue. It's not a "feature", and I'm sorry, but anybody who
calls x86 "peanuts" is a moron and should be ashamed of himself.
Instead of trying to feel superior, those people should feel like
pariah.

The fact that x86 has a platform, and people have cared about
compatibility, and actually gets things to work with less code is a
good thing. I know ARM people who think that x86 is an "ugly"
architecture. But the fact is, of all the architectures out there, ARM
right now is the ugliest BY FAR. Exactly because of people who don't
seem to understand that this kind of crap is a problem.

                    Linus
