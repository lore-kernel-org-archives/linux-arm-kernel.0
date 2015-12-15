From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 15 Dec 2015 16:52:37 +0800
Subject: [PATCH] ARM: dts: imx: Fix the assigned-clock mismatch issue on
 imx6q/dl
In-Reply-To: <20151214030750.GF25756@tiger>
References: <1449648955-30835-1-git-send-email-b51503@freescale.com>
 <20151214030750.GF25756@tiger>
Message-ID: <20151215085237.GB388@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 11:07:50AM +0800, Shawn Guo wrote:
> On Wed, Dec 09, 2015 at 04:15:55PM +0800, Bai Ping wrote:
> > The 'assigned-clock-parents' and 'assigned-clock-rates' list
> > should corresponding to the 'assigned-clocks' property clock list.
> > 
> > Signed-off-by: Bai Ping <b51503@freescale.com>
> 
> Applied, thanks.

As this essentially a fix to ed339363de1b ("ARM: dts: imx6qdl-sabreauto:
Allow HDMI and LVDS to work simultaneously"), I'm going to send it as a
fix with copying stable.

@Fabio,

Do you agree with the fix?

Shawn
