From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 2 Dec 2015 15:55:37 +0100
Subject: [PATCH 0/5] ARM: orion5x/dove/mv78xx0 multiplatform
In-Reply-To: <87fuzl2jm5.fsf@free-electrons.com>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
 <87610j7gmc.fsf@free-electrons.com>
 <87wpsz61r7.fsf@free-electrons.com>
 <20151201182226.ea7d860eb3a35086981cd18f@vollmann.ch>
 <87fuzl2jm5.fsf@free-electrons.com>
Message-ID: <20151202145537.GJ29814@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 02, 2015 at 12:08:34PM +0100, Gregory CLEMENT wrote:
> Hi Detlef,
>  
>  On mar., d?c. 01 2015, Detlef Vollmann <dv@vollmann.ch> wrote:
> 
> > On Mon, 30 Nov 2015 14:43:56 +0100
> > Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:
> > [...]
> >> > Detlef, Benjamin,
> >> >
> >> > could you test it on an Orion5x based board?
> > Sorry, I'm on tour right now.
> > I'll test it next weekend (or beginning next week) on my DNS-323.
> 
> We have still some time to send the series, and furthermore Andrew
> already tested it on an Orion5x platform. However it would be nice to
> have your confirmation on an other board.

Hi Gregory

To help with testing, could you pull the defconfig changes into the
branch? I cannot boot the multi_v5_defconfig on my Orion5x. Its CPU is
too old, and needs CONFIG_CPU_FEROCEON_OLD_ID, but that is not
available because CPU_ARM926T is enabled.

Thanks
	  Andrew
