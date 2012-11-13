From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 13 Nov 2012 10:52:13 +0800
Subject: [PATCH] i.MX IPU SoC support
In-Reply-To: <1352733809-27230-1-git-send-email-s.hauer@pengutronix.de>
References: <1352733809-27230-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20121113025212.GC1119@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 04:23:22PM +0100, Sascha Hauer wrote:
> This series adds the necessary i.MX SoC stuff to make the IPU support
> usable. Basically needed are the IPU devices in the devicetrees. This
> series also adds display support for the i.MX51 babbage which then is
> the first board for which the IPU driver works without out of tree
> stuff.
> 
> Shawn, I already sent the MIPI setup patch some time ago. From what
> I read I think we can agree on the approach on just setting the correct
> register values in the SoC code, right?
> 
For the series,

Acked-by: Shawn Guo <shawn.guo@linaro.org>
