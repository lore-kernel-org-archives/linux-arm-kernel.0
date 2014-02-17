From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Feb 2014 10:22:23 +0800
Subject: [PATCH] dma: sdma: Add imx25 compatible
In-Reply-To: <1392577855-23375-1-git-send-email-mpa@pengutronix.de>
References: <1392577855-23375-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20140217022221.GF9879@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 16, 2014 at 08:10:55PM +0100, Markus Pargmann wrote:
> imx25 did not work without a firmware previously.
> 
> This patch adds a DT compatible to pass the correct data with the
> default script addresses for imx25.
> 
> Add imx25 compatible to the list of compatibles in the binding
> documentation.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
