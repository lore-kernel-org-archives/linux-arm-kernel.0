From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Sep 2012 12:33:08 +0000
Subject: [PATCH 5/6] ARM: dove: Remove watchdog from DT
In-Reply-To: <201209251120.54255.arnd@arndb.de>
References: <1348531338-16624-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20120925103141.GG27099@lunn.ch> <201209251120.54255.arnd@arndb.de>
Message-ID: <201209251233.09060.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 25 September 2012, Arnd Bergmann wrote:
> On Tuesday 25 September 2012, Andrew Lunn wrote:
> > > Regarding mv78xx0, I agree that I'm not sure what to do. The number of
> > > supported platforms is small. Should we simply mark mv78xx0 deprecated
> > > now, wait a few release cycles to see if anyone shows up, and see what
> > > to do at this point?
> 
> We should let Sebastien Requiem comment. He is the only person outside of
> Marvell who has contributed a board file for mv78xx0. If he's interested in
> keeping it alive, he's hopefully also able to find the time to test the
> devicetree version of that platform in mach-mvebu. Similarly, if anyone
> has the MASA reference design, that one could be moved over to mach-mvebu
> first.
> 
> There is a much smaller user base for mv78xx0 than for orion5x, so as long
> as we can keep the support working with DT, we can throw out the legacy
> code much faster than for orion. If it doesn't get put into mach-mvebu
> and you can't find anyone who has hardware to test on, you could also
> stop maintaining it and leave it to bitrot, but I wouldn't just remove it
> on a fast track then.

The address I used for Sebastien appears to be dead. Maybe this one still
works.

	Arnd
