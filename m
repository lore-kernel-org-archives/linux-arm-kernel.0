From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 7 Dec 2015 15:03:09 +0100
Subject: [PATCH CFT] ARM: orion: implement ARM delay timer
In-Reply-To: <20151207101914.GM8644@n2100.arm.linux.org.uk>
References: <E1ZoD3b-0006UD-Rp@rmk-PC.arm.linux.org.uk>
 <20151207101914.GM8644@n2100.arm.linux.org.uk>
Message-ID: <20151207140309.GC1118@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 10:19:14AM +0000, Russell King - ARM Linux wrote:
> On Mon, Oct 19, 2015 at 05:13:07PM +0100, Russell King wrote:
> > Implement an ARM delay timer to be used for udelay() on orion legacy
> > platforms.  This allows us to skip the delay loop calibration at boot.
> > 
> > It also means that udelay() will be unaffected by CPU frequency changes
> > when cpufreq is enabled on these platforms.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> > This needs to be tested beyond build testing...
> 
> So what's happening with this change?  I see no progress on it.

I said on IRC you had now tested it. Please send a Tested-by:

  Andrew
