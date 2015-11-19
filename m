From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Nov 2015 20:36:47 +0100
Subject: [GIT PULL] at91: fixes for 4.4 #1
In-Reply-To: <564E0A99.9020707@atmel.com>
References: <1447760158-20204-1-git-send-email-nicolas.ferre@atmel.com>
 <5616576.CPP4uTUkOp@wuerfel> <564E0A99.9020707@atmel.com>
Message-ID: <4698828.tp5rD5DIKm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 November 2015 18:44:57 Nicolas Ferre wrote:
> Le 19/11/2015 16:22, Arnd Bergmann a ?crit :
> > On Tuesday 17 November 2015 12:35:58 Nicolas Ferre wrote:
> >> Arnd, Olof, Kevin,
> >>
> >> This is the first "fixes" pull-request for AT91. I tried to collect little
> >> patches that didn't make it for -rc1.
> >> It can be due to synchronization between trees like the addition of some
> >> sama5d2 Xplained nodes (MFD tree) or the change of the watchdog compatible
> >> string for sama5d4 (watchdog tree).
> >> It can also be due to trivial cleanups that were spotted or submitted late like
> >> the replacement of "wakeup" properties or removal of unneeded defconfig option.
> >> The removal of some dead legacy DT properties or nodes is, in my opinion worth
> >> it as well in order to prevent us from abusive cut'n paste.
> >> NAND and ISI Atmel MAINTAINERS entries are also updated.
> >>
> >> Tell me if it's okay for you.
> > 
> > I'd be happier to get the patches late in the process and then push back
> > myself than to get them as fixes, there was really no reason to wait
> > for the merge window to end with the ones that you already had.
> 
> I thought than having a precise milestone as a base for this
> pull-request would be preferred.

It is, but if you have a branch that introduces or exposes a bug,
then I'd prefer to get a pull request with the bug fixes on top
of the branch that we already have, e.g. the at91/dt branch
(as opposed to next/dt or for-next, which would be wrong).

	Arnd
