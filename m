From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Nov 2011 22:55:29 +0000
Subject: [PATCH] arm: omap2+: hwmod: fix breakage introduced by d6504acd
In-Reply-To: <20111107225157.GB31337@atomide.com>
References: <1320688617-4543-1-git-send-email-balbi@ti.com>
 <20111107183208.GG15294@n2100.arm.linux.org.uk>
 <20111107193908.GA5059@legolas.emea.dhcp.ti.com>
 <20111107212707.GH15294@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.1111071428001.12394@utopia.booyaka.com>
 <20111107224129.GJ15294@n2100.arm.linux.org.uk>
 <20111107225157.GB31337@atomide.com>
Message-ID: <20111107225529.GK15294@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2011 at 02:51:57PM -0800, Tony Lindgren wrote:
> Here's what I got. Looks like the removal of the sr[12]_hwmod
> part is no longer needed, so only the r value check part is needed.

Err.  So do you have anything in your git tree which you're pushing out
this evening which removes the sr[12]_hwmod from the omap_3xxx_hwmod
list?

If not, how does that bug get fixed in mainline?
