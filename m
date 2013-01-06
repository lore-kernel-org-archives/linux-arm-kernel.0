From: anton@enomsg.org (Anton Vorontsov)
Date: Sun, 6 Jan 2013 14:04:27 -0800
Subject: [PATCH 3/4] Power: Reset: Power off by restarting
In-Reply-To: <201212281959.38035.michael@walle.cc>
References: <1356697512-3950-1-git-send-email-andrew@lunn.ch>
 <1356697512-3950-4-git-send-email-andrew@lunn.ch>
 <201212281959.38035.michael@walle.cc>
Message-ID: <20130106220426.GE26928@lizard.sbx05280.losalca.wayport.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 28, 2012 at 07:59:37PM +0100, Michael Walle wrote:
> Am Freitag 28 Dezember 2012, 13:25:11 schrieb Andrew Lunn:
> > Some devices, Buffalo Linkstation LS-XHL and LS-CHLv2 for example,
> > power-off by restarting to letting u-boot hold the SoC until the user
> > presses a key. Add a generic driver to implement this. It binds a
> > function to pm_power_off, which calls arm_pm_restart.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
[...]
> Tested-by: Michael Walle <michael@walle.cc>

Applied (with a small cosmetic cleanups), thanks a lot!

Note that I can also take the ARM patches together with the drivers (and
it would make sense to keep things bisectable). Should I?

Thanks,
Anton
