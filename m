From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Dec 2015 15:00:36 +0000
Subject: [PATCH CFT] ARM: orion: implement ARM delay timer
In-Reply-To: <20151207140309.GC1118@lunn.ch>
References: <E1ZoD3b-0006UD-Rp@rmk-PC.arm.linux.org.uk>
 <20151207101914.GM8644@n2100.arm.linux.org.uk>
 <20151207140309.GC1118@lunn.ch>
Message-ID: <20151207150035.GQ8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 03:03:09PM +0100, Andrew Lunn wrote:
> On Mon, Dec 07, 2015 at 10:19:14AM +0000, Russell King - ARM Linux wrote:
> > On Mon, Oct 19, 2015 at 05:13:07PM +0100, Russell King wrote:
> > > Implement an ARM delay timer to be used for udelay() on orion legacy
> > > platforms.  This allows us to skip the delay loop calibration at boot.
> > > 
> > > It also means that udelay() will be unaffected by CPU frequency changes
> > > when cpufreq is enabled on these platforms.
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > > ---
> > > This needs to be tested beyond build testing...
> > 
> > So what's happening with this change?  I see no progress on it.
> 
> I said on IRC you had now tested it. Please send a Tested-by:

Sorry, I've totally lost track, I'd forgotten that it gets used on Dove.

Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
