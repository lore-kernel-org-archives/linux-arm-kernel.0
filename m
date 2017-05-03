From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 May 2017 22:30:35 +0100
Subject: [PATCH] ARM: Fix __show_regs output timestamps
In-Reply-To: <1493840651.22125.24.camel@perches.com>
References: <61817479ac8c4c6c8be702d2e2136fddac1b1821.1493228290.git.joe@perches.com>
 <20170503192310.GD22219@n2100.armlinux.org.uk>
 <1493840651.22125.24.camel@perches.com>
Message-ID: <20170503213034.GF22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 03, 2017 at 12:44:11PM -0700, Joe Perches wrote:
> On Wed, 2017-05-03 at 20:23 +0100, Russell King - ARM Linux wrote:
> > On Wed, Apr 26, 2017 at 10:39:49AM -0700, Joe Perches wrote:
> > > Multiple line formats are not preferred as the second and
> > > subsequent lines may not have timestamps.
> > > 
> > > Lacking timestamps makes reading the output a bit difficult.
> > > This also makes arm/arm64 output more similar.
> > > 
> > > Previous:
> > > 
> > > [ 1514.093231] pc : [<bf79c304>]    lr : [<bf79ced8>]    psr: a00f0013
> > > sp : ecdd7e20  ip : 00000000  fp : ffffffff
> > > 
> > > New:
> > > 
> > > [ 1514.093231] pc : [<bf79c304>]    lr : [<bf79ced8>]    psr: a00f0013
> > > [ 1514.105316] sp : ecdd7e20  ip : 00000000  fp : ffffffff
> > > 
> > > Signed-off-by: Joe Perches <joe@perches.com>
> > 
> > Hi Joe,
> > 
> > Could you put this in my patch system please, I'm unlikely to remember to
> > apply it otherwise if not already there (massive email backlog.)
> > 
> > Thanks.
> 
> Your patch system bounced my perfectly formatted patch
> because your system wants totally unnecessary additional
> information specific to your workflow.
> 
> No thanks, I don't need the additional work just to
> please your system and neither should anyone else.

Don't expect me to remember to apply your patch then.  I've got days of
catch up, and I'm just not going to remember.  Sorry.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
