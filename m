From: anton@enomsg.org (Anton Vorontsov)
Date: Sun, 6 Jan 2013 23:00:08 -0800
Subject: [PATCH 3/4] Power: Reset: Power off by restarting
In-Reply-To: <20130107064202.GB24650@lunn.ch>
References: <1356697512-3950-1-git-send-email-andrew@lunn.ch>
 <1356697512-3950-4-git-send-email-andrew@lunn.ch>
 <201212281959.38035.michael@walle.cc>
 <20130106220426.GE26928@lizard.sbx05280.losalca.wayport.net>
 <20130107064202.GB24650@lunn.ch>
Message-ID: <20130107070008.GB31407@lizard.gateway.2wire.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 07, 2013 at 07:42:02AM +0100, Andrew Lunn wrote:
> On Sun, Jan 06, 2013 at 02:04:27PM -0800, Anton Vorontsov wrote:
> > On Fri, Dec 28, 2012 at 07:59:37PM +0100, Michael Walle wrote:
> > > Am Freitag 28 Dezember 2012, 13:25:11 schrieb Andrew Lunn:
> > > > Some devices, Buffalo Linkstation LS-XHL and LS-CHLv2 for example,
> > > > power-off by restarting to letting u-boot hold the SoC until the user
> > > > presses a key. Add a generic driver to implement this. It binds a
> > > > function to pm_power_off, which calls arm_pm_restart.
> > > > 
> > > > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > [...]
> > > Tested-by: Michael Walle <michael@walle.cc>
> > 
> > Applied (with a small cosmetic cleanups), thanks a lot!
> > 
> > Note that I can also take the ARM patches together with the drivers (and
> > it would make sense to keep things bisectable). Should I?
> 
> Hi Anton
> 
> Do you have a stable branch containing these patches?

Stable as in 'I don't rebase it'? Yes, I tend to not rebase the battery
tree. It is here:

	git://git.infradead.org/battery-2.6.git master

You can find the applied patches there.

Thanks,
Anton
