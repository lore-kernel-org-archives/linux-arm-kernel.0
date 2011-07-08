From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 8 Jul 2011 08:29:42 +0200
Subject: [GIT PULL] i.MX feature additions
In-Reply-To: <201107071629.50713.arnd@arndb.de>
References: <20110707081711.GZ6069@pengutronix.de>
	<201107071629.50713.arnd@arndb.de>
Message-ID: <20110708062942.GC6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 07, 2011 at 04:29:50PM +0200, Arnd Bergmann wrote:
> On Thursday 07 July 2011, Sascha Hauer wrote:
> > Arnd,
> > 
> > Please pull the following i.MX feature additions. This one is based on
> > the previous cleanup branch due to merge conflicts we would get
> > otherwise. I carefully looked that the end result is the same as the
> > previous devel pull request you denied.
> 
> Ok, pulled everything and pushed out again.
> 
> The last series had a number of patches that would qualify as cleanups
> IMHO, like most of the work from Shawn.

You probably mean the SDMA patches. These were done against the state of
the tree at that time and putting these into the cleanup branch would
have resulted in merge conflicts. I'll do my best to keep the topics
seperate but this will happen again as many changes to the tree are not
so orthogonal as you wish them to be.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
