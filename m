From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Feb 2014 22:32:20 +0100
Subject: [PATCH v2 2/5] ARM: mvebu: Add i2c alias so setting bus number
In-Reply-To: <20140224193050.GG1010@titan.lakedaemon.net>
References: <1393264898-28939-1-git-send-email-andrew@lunn.ch>
 <20140224191108.GA29288@lunn.ch> <20140224193050.GG1010@titan.lakedaemon.net>
Message-ID: <201402242232.20851.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 February 2014, Jason Cooper wrote:

> 
> ex: What changed from v3.15 to v3.16 for kirkwood?
> 
> $ git log --oneline v3.15..v3.16 -- arch/arm/mach-mvebu | \
>         grep -i 'ARM: kirkwood'
> 
> This seems to be new territory for us (mvebu), perhaps one of the
> arm-soc maintainers has a preference?  I'll add them to this reply.

I don't care, as long as you decide on something that works for you.
While you're transitioning, it probably makes little sense to
enforce either one too strictly.

	Arnd
