From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Apr 2012 20:15:41 +0000
Subject: Sharing header files -- arch/arm/mach-generic  ?
In-Reply-To: <20120423194042.GA5734@elf.ucw.cz>
References: <20120423194042.GA5734@elf.ucw.cz>
Message-ID: <201204232015.41963.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 April 2012, Pavel Machek wrote:
> I have new architecture I'd like to merge into the mainline. It has
> some code very similar to existing plaforms (for example
> real differences to mach-realview/platsmp.c are two lines.)
> 
> Is that a problem?
> 
> Should mach-generic/platsmp.c be created, so code can be better
> shared? Or are the code pieces small enough that this duplication can
> be ignored?

Hi Pavel,

I'd suggest you just post the code with the duplicate files
for review at first, and then we can discuss what to do with them.
As Russell mentioned, the code might not actually be ideal
in the duplicate version so you end up rewriting it, or there
might be a different solution that someone finds when we see the
patches.

	Arnd
