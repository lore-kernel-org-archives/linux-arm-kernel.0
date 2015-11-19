From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Nov 2015 16:22:07 +0100
Subject: [GIT PULL] at91: fixes for 4.4 #1
In-Reply-To: <1447760158-20204-1-git-send-email-nicolas.ferre@atmel.com>
References: <1447760158-20204-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <5616576.CPP4uTUkOp@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 November 2015 12:35:58 Nicolas Ferre wrote:
> Arnd, Olof, Kevin,
> 
> This is the first "fixes" pull-request for AT91. I tried to collect little
> patches that didn't make it for -rc1.
> It can be due to synchronization between trees like the addition of some
> sama5d2 Xplained nodes (MFD tree) or the change of the watchdog compatible
> string for sama5d4 (watchdog tree).
> It can also be due to trivial cleanups that were spotted or submitted late like
> the replacement of "wakeup" properties or removal of unneeded defconfig option.
> The removal of some dead legacy DT properties or nodes is, in my opinion worth
> it as well in order to prevent us from abusive cut'n paste.
> NAND and ISI Atmel MAINTAINERS entries are also updated.
> 
> Tell me if it's okay for you.

I'd be happer to get the patches late in the process and then push back
myself than to get them as fixes, there was really no reason to wait
for the merge window to end with the ones that you already had.

None of the changes look too invasive for -rc2, so I'm taking it anway,
but please try to let us know what you have earlier next time, so we
can get the first fixes into the merge window, or add them as late
additions on the branches before sending the main pull requests.

Inter-tree dependencies should never be a reason to send stuff after
-rc1, let's talk about that before the merge window if you know you
have those.

	Arnd
