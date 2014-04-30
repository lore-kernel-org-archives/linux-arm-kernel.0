From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 30 Apr 2014 22:21:30 +0200
Subject: [PATCH 03/15] ARM: dts: kirkwood: add stdout-path property to
 all boards
In-Reply-To: <53615342.8010600@gmail.com>
References: <1398862602-29595-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1398862602-29595-4-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140430163807.GA3082@lunn.ch> <53615342.8010600@gmail.com>
Message-ID: <20140430202130.GE3082@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Yes, we *can* move it in kirkwood.dtsi, but IMHO we *should* keep it in
> the board files. I see the "chosen" node and its properties as _the_
> board node.
> 
> One could argue then, that we should count the memory properties too and
> put the most common in the SoC dtsi. But you are right, as UART0 is also
> the UART with boot support, it is likely to be always connected to
> a more-or-less accessible console output.
> 
> I really have no strong opinion about it.

Me neithe, but the advantage of putting it in kirkwood.dtsi is that it
then does not get forgotten, and is always there for bearbox to use.

    Andrew
