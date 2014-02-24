From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 24 Feb 2014 17:15:12 -0500
Subject: [PATCH v2 2/5] ARM: mvebu: Add i2c alias so setting bus number
In-Reply-To: <201402242232.20851.arnd@arndb.de>
References: <1393264898-28939-1-git-send-email-andrew@lunn.ch>
 <20140224191108.GA29288@lunn.ch>
 <20140224193050.GG1010@titan.lakedaemon.net>
 <201402242232.20851.arnd@arndb.de>
Message-ID: <20140224221512.GH1010@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 10:32:20PM +0100, Arnd Bergmann wrote:
> On Monday 24 February 2014, Jason Cooper wrote:
> 
> > 
> > ex: What changed from v3.15 to v3.16 for kirkwood?
> > 
> > $ git log --oneline v3.15..v3.16 -- arch/arm/mach-mvebu | \
> >         grep -i 'ARM: kirkwood'
> > 
> > This seems to be new territory for us (mvebu), perhaps one of the
> > arm-soc maintainers has a preference?  I'll add them to this reply.
> 
> I don't care, as long as you decide on something that works for you.

Ok, we'll wait till we have an actual problem ;-)  Seriously though,
once dove and kirkwood are both migrated, we'll sit down and hash out
how to handle it (if needed at all).

> While you're transitioning, it probably makes little sense to
> enforce either one too strictly.

Agreed.  Andrew, let's stick with the previous pseudo-file/path standard
for now.  If you're inclined, please change the dts patches to kirkwood.
If you don't feel like it, I'll only twitch a little bit.  :)

thx,

Jason.
