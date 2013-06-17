From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 17 Jun 2013 13:59:48 -0700
Subject: [PATCH v2] staging: imx_drm: imx_ldb: fix 18 bit format
In-Reply-To: <1371459772-16443-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1371459772-16443-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <20130617205948.GA3018@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 11:02:52AM +0200, Steffen Trumtrar wrote:
> From: Markus Niebel <Markus.Niebel@tqs.de>
> 
> Since 18 bit is supported as datawidth in device tree it should be
> supported in driver. Beside the LDB channel the IPU channel has also
> to be configured to use BGR666.
> 
> Signed-off-by: Markus Niebel <Markus.Niebel@tqs.de>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Tested-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> This is based on the series: "staging: drm/imx: Add LDB support" by Philipp.

I don't seem to have that series in my queue anywhere, can someone
please resend it, and this patch, so that I can apply them?

thanks,

greg k-h
