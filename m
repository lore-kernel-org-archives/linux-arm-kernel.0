From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Apr 2014 22:30:21 +0200
Subject: [PATCH 03/15] ARM: dts: kirkwood: add stdout-path property to all
 boards
In-Reply-To: <20140430202130.GE3082@lunn.ch>
References: <1398862602-29595-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <53615342.8010600@gmail.com> <20140430202130.GE3082@lunn.ch>
Message-ID: <142642785.6KSg8q4tJP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 April 2014 22:21:30 Andrew Lunn wrote:
> > Yes, we *can* move it in kirkwood.dtsi, but IMHO we *should* keep it in
> > the board files. I see the "chosen" node and its properties as _the_
> > board node.
> > 
> > One could argue then, that we should count the memory properties too and
> > put the most common in the SoC dtsi. But you are right, as UART0 is also
> > the UART with boot support, it is likely to be always connected to
> > a more-or-less accessible console output.
> > 
> > I really have no strong opinion about it.
> 
> Me neithe, but the advantage of putting it in kirkwood.dtsi is that it
> then does not get forgotten, and is always there for bearbox to use.

I would prefer having it in the board.dts file out of principle, but I
agree it's not very important either way.

	Arnd
