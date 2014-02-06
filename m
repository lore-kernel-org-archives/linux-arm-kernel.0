From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 06 Feb 2014 17:38:28 +0100
Subject: [PATCH 4/4] ARM: Kirkwood: Add support for many Synology NAS
 devices
In-Reply-To: <20140206160126.GH29860@lunn.ch>
References: <1391634309-3123-1-git-send-email-andrew@lunn.ch>
 <20140206153939.GD8533@titan.lakedaemon.net> <20140206160126.GH29860@lunn.ch>
Message-ID: <107057891.kz6j7UkZNk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 February 2014 17:01:26 Andrew Lunn wrote:

> , but this is, imho,
> > over-fragmenting.  I'm sure there's a reason you chose this path, but
> > you haven't explained why in your commit log. So I'm left guessing...
> 
> Synology seem to build there devices like lego. They have two
> different RTC blocks. They have three different fan alarm blocks, four
> different led blocks, etc. And to build a product, the just select a
> group of blocks and put them together.

I guess the Armada-370 and newer based ds213j and dsx14 will also be
able to reuse some of the blocks, right?

	Arnd
