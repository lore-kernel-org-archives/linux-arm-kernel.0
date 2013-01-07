From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 7 Jan 2013 06:27:47 -0500
Subject: [PATCH 3/4] Power: Reset: Power off by restarting
In-Reply-To: <20130106220426.GE26928@lizard.sbx05280.losalca.wayport.net>
References: <1356697512-3950-1-git-send-email-andrew@lunn.ch>
 <1356697512-3950-4-git-send-email-andrew@lunn.ch>
 <201212281959.38035.michael@walle.cc>
 <20130106220426.GE26928@lizard.sbx05280.losalca.wayport.net>
Message-ID: <20130107112747.GE5075@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 06, 2013 at 02:04:27PM -0800, Anton Vorontsov wrote:
> On Fri, Dec 28, 2012 at 07:59:37PM +0100, Michael Walle wrote:
> > Am Freitag 28 Dezember 2012, 13:25:11 schrieb Andrew Lunn:
> > > Some devices, Buffalo Linkstation LS-XHL and LS-CHLv2 for example,
> > > power-off by restarting to letting u-boot hold the SoC until the user
> > > presses a key. Add a generic driver to implement this. It binds a
> > > function to pm_power_off, which calls arm_pm_restart.
> > > 
> > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> [...]
> > Tested-by: Michael Walle <michael@walle.cc>
> 
> Applied (with a small cosmetic cleanups), thanks a lot!
> 
> Note that I can also take the ARM patches together with the drivers (and
> it would make sense to keep things bisectable). Should I?

Please take patches 1 and 3 of this series (which it looks like you
have).  I'll take 2 and 4 and list your stable tree as a dependency.

thx,

Jason.
