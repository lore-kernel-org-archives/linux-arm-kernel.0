From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Nov 2013 10:19:48 +0800
Subject: [PATCH] ARM: i.MX6q: fix the wrong parent of can_root clock
In-Reply-To: <52937E6F.1020102@pengutronix.de>
References: <1383132351-32112-1-git-send-email-jiada_wang@mentor.com>
 <20131031073820.GH23549@S2101-09.ap.freescale.net>
 <52937E6F.1020102@pengutronix.de>
Message-ID: <20131126021946.GC30476@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 05:44:31PM +0100, Marc Kleine-Budde wrote:
> On 10/31/2013 08:38 AM, Shawn Guo wrote:
> > On Wed, Oct 30, 2013 at 04:25:51AM -0700, jiada_wang at mentor.com wrote:
> >> From: Jiada Wang <jiada_wang@mentor.com>
> >>
> >> instead of pll3_usb_otg the parent of can_root clock
> >> should be pll3_60m.
> >>
> >> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
> > 
> > Applied, thanks.
> 
> Can you put stable on Cc?

Sorry, it already hits mainline.

I generally do not judge if a patch is suitable for stable tree, and
rely on patch sender to explicitly request by marking stable and the
prerequisite commits if any.

Shawn
