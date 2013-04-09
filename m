From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 16:05:59 +0200
Subject: [GIT PULL] ux500 multiplatform tags
In-Reply-To: <CACRpkdbPZ5Nvv9+Bz9UE-U6-9QpqAr6UKGyYrTAxj78SJaknvg@mail.gmail.com>
References: <CACRpkdbPZ5Nvv9+Bz9UE-U6-9QpqAr6UKGyYrTAxj78SJaknvg@mail.gmail.com>
Message-ID: <201304091605.59598.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 April 2013, Linus Walleij wrote:
> Hi ARM SoC folks and Sam,
> 
> These are the two multiplatform tags for MFD and ARM SoC.
> 
> As agreed there is one tag for a number of MFD patches that
> remove the <mach/*> dependencies from the DB8500 PRCMU
> driver, then another tag dependent on the former that from that
> point switches to multiplatform.
> 
> Below are two tags on git request-pull formar: the first one
> is for *both* trees, MFD and ARM SoC, the second is only
> for ARM SoC.
> 
> I have moved a few hunks and introduced a new patch in the
> MFD series to make things compile and bisect properly.
> Notably the patch "mfd: db8500-prcmu: drop unused includes"
> is a new one, but the end result is textually equivalent to what
> has already been posted so I consider this a reviewed patch
> set and the split as plain mechanics.
> 
> Please pull your applicable branches!

Pulled into next/multiplatform, thanks a lot!

	Arnd
