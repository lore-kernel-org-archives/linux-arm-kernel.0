From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Dec 2015 01:03:59 +0100
Subject: [PATCH v2 0/8] Raspberry Pi 2 support.
In-Reply-To: <1450310115-22163-1-git-send-email-eric@anholt.net>
References: <1450310115-22163-1-git-send-email-eric@anholt.net>
Message-ID: <21040591.KakM5Gl6ZZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 December 2015 15:55:07 Eric Anholt wrote:
> This is a major rewrite of the previous Raspberry Pi 2 submission.
> SMP support is now included, and the DT includes are cleaned up to
> avoid massive duplication.
> 
> The branch (based on 4.4-rc5, to get the USB regression fixes) can be
> found at:
> 
> https://github.com/anholt/linux/tree/bcm2836-4.4

Looks all good to me, but when we get the pull request, I'd strongly
prefer to have that based on -rc3 or earlier.

What commit is the USB regression fix you refer to above? Is that in a
branch that is -rc3 based? Maybe you can rebase the changes on top
of that branch, to minimize the amount of backmerges?

	Arnd
