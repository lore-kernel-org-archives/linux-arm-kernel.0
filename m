From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 Jan 2013 09:58:23 +0800
Subject: [PATCH 1/4] ARM i.MX53: Add UART2 for low-level debugging
In-Reply-To: <1357739065-9153-2-git-send-email-s.trumtrar@pengutronix.de>
References: <1357739065-9153-1-git-send-email-s.trumtrar@pengutronix.de>
 <1357739065-9153-2-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <20130110015821.GB2265@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 09, 2013 at 02:44:22PM +0100, Steffen Trumtrar wrote:
> From: Philipp Zabel <p.zabel@pengutronix.de>
> 
> This is needed for boards like the Garz & Fricke Vincell and
> Vincell LT, that have the serial debugging console on UART2.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

I have a patch [1] to solve it for all imx and all uart ports.

Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/205000/focus=205002
