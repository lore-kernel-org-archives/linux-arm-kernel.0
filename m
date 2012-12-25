From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 25 Dec 2012 19:08:48 +0800
Subject: [PATCH] ehci-mxc: remove Efika MX-specific CHRGVBUS hack
In-Reply-To: <1356261362-8418-1-git-send-email-matt@genesi-usa.com>
References: <1356261362-8418-1-git-send-email-matt@genesi-usa.com>
Message-ID: <20121225110845.GB14088@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 23, 2012 at 05:16:02AM -0600, Matt Sealey wrote:
> Since Efika MX platform support (pre-devicetree) was removed from the tree
> this code no longer has any possibility of running and clutters up the
> driver which is being replaced by the chipidea host in the future anyway.
> 
> Signed-off-by: Matt Sealey <matt@genesi-usa.com>
> Tested-by: Steev Klimazewski <steev@genesi-usa.com>
> CC: Sascha Hauer <kernel@pengutronix.de>
> CC: Alan Stern <stern@rowland.harvard.edu>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
