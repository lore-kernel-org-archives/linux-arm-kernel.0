From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 8 Apr 2014 16:14:42 +0800
Subject: [PATCH] ARM: dt: microsom: don't set bit 7 for ethernet mux
 settings
In-Reply-To: <E1WWvc1-0004DM-62@rmk-PC.arm.linux.org.uk>
References: <E1WWvc1-0004DM-62@rmk-PC.arm.linux.org.uk>
Message-ID: <20140408081440.GG2438@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 06, 2014 at 11:32:25PM +0100, Russell King wrote:
> Bit 6,7 are marked as reserved for the ethernet RGMII pins, so avoid
> setting these bits.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Applied, thanks.

I'm wondering if this is an error found by code/doc inspection, or it
fixes a real problem?

Shawn
