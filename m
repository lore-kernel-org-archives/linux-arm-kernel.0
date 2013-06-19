From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jun 2013 01:54:34 +0200
Subject: [GIT PULL] U300 multiplatform for v3.11
In-Reply-To: <CACRpkdY1EUbFK6Mk3nogjGGeSkmio2v6ZNFe1wh7sFcE3d51fg@mail.gmail.com>
References: <CACRpkdY1EUbFK6Mk3nogjGGeSkmio2v6ZNFe1wh7sFcE3d51fg@mail.gmail.com>
Message-ID: <201306200154.34447.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 17 June 2013, Linus Walleij wrote:
> this is my big pull request for the U300 device tree and multiplatform work
> queued for v3.11. It represents my best effort to do this as well as possible
> to this point.
> 
> After this the mach-u300 likely looks much more appetizing than before and
> none of the changes are such that they cannot be undone if need be.
> The only outstanding issue was that of the specific board node used
> to hog board power, a patch to do that from the regulator driver was
> rejected by the regulator maintainer asking that it be done from the
> reset subsystem (power) instead, and that can certainly be done as
> a refactoring for the next cycle, just as the movement to the regulator
> driver was sent as a refactoring patch.
> 
> All patches outside arch/arm/* have been ACKed by repective subsystem
> maintainer except for the RTC COH 901331 driver where I have had no
> response from the RTC maintainer for two months, and the patch is small
> and fairly standard so now I suggest we merge that anyway.
> 
> One could argue that some patches could have been delivered on
> separate branches, for example the two fixes from Ulf Hansson and
> Peter Huewe, but since the DT and multiplat conversion touches
> absolutely everything, I am saving you some hours of conflict
> resolution between these things by delivering it all on one branch.
> Trying to deliver device tree and multiplatform on two branches
> would have caused eternal headaches for sure.

Great work!

Pulled into next/soc now.

	Arnd
