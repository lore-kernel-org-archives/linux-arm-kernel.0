From: joe@perches.com (Joe Perches)
Date: Wed, 02 Jun 2010 15:29:17 -0700
Subject: kirkwood: Iomega ix4-200d support?
Message-ID: <1275517757.23599.86.camel@Joe-Laptop.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's also called the IX4-110.

Now that I have one, I'd like to add support for this board
in arch/arm/mach-kirkwood.

File layout has changed since EMC released their kernel 2.6.22.18
with support for this board.

I'm looking for suggestions on where to put the files for
the GPIO driven lcd module.  Should I just drop them into
arch/arm/mach-kirkwood or is there a better generic location?
