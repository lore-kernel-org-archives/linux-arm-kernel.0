From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Apr 2014 09:54:28 +0200
Subject: [PATCH] arm64:kconfig: make default for CONFIG_COMPAT
References: <1397462883-12740-1-git-send-email-chanho.min@lge.com>
 <20140414164618.GC12916@arm.com>
Message-ID: <4386453.rooF7jKWKy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 April 2014 09:07:00 Chanho Min wrote:
> > -----Original Message-----
> > From: Will Deacon [mailto:will.deacon at arm.com]
> > Sent: Tuesday, April 15, 2014 1:46 AM
> > To: Chanho Min
> > Cc: Catalin Marinas; linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> > Subject: Re: [PATCH] arm64:kconfig: make default for CONFIG_COMPAT
> > 
> > On Mon, Apr 14, 2014 at 09:08:03AM +0100, Chanho Min wrote:
> > > 'make savedefconfig' doesn't generate defconfig properly due to
> > > missing COMPAT default. So Add default and set to yes.
> > 
> > I thought a missing `default' line in a Kconfig entry meant that the option
> > ended up defaulting to 'n'. What exactly is the problem you are seeing?
> 
> Correct minimal config is not generated without default line.
> If we want to set COMPAT to 'n', 'default n' should be added.

That would be pointless, because 'n' is already the default.
What do you want to achieve?

	Arnd
