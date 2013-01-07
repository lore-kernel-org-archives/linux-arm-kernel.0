From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 7 Jan 2013 11:55:46 -0500
Subject: [PATCH 4/4] arm: mvebu: indentation fixes for Armada 370/XP
 .dtsi files
In-Reply-To: <20130107175311.3fbbf68d@skate>
References: <1357315498-4570-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1357315498-4570-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130106090313.GP17242@lunn.ch> <20130107175311.3fbbf68d@skate>
Message-ID: <20130107165546.GJ5075@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 07, 2013 at 05:53:11PM +0100, Thomas Petazzoni wrote:
> Dear Andrew Lunn,
> 
> On Sun, 6 Jan 2013 10:03:13 +0100, Andrew Lunn wrote:
> 
> > White space changes are not fixes, so should not really be submitted
> > for 3.8-rc. Lets commit these as cleanup in 3.9.
> > 
> > I will however create and submit a patch to add the missing ;
> 
> Indeed, thanks. I'll resubmit an updated patch for 3.9 for some
> whitespace changes.

Thomas,

I assume you're running a sed script of some sort.  If so, could you
also hit kirkwood-*.dts*, dove, orion5x?

thx,

Jason.
