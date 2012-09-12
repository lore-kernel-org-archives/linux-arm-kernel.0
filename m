From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 12 Sep 2012 09:49:29 -0700
Subject: [PATCH 1/6] staging: drm/imx: Add i.MX drm core support
In-Reply-To: <1347445874-10779-2-git-send-email-s.hauer@pengutronix.de>
References: <1347445874-10779-1-git-send-email-s.hauer@pengutronix.de>
 <1347445874-10779-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120912164929.GA24538@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 12:31:09PM +0200, Sascha Hauer wrote:
> This patch adds the i.MX glue stuff between i.MX and drm.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/staging/Kconfig                |    2 +
>  drivers/staging/Makefile               |    1 +

The patch fails at this point when applying it.

What tree did you make it against?  Please do so against linux-next or
hopefully, the staging-next branch, and resubmit these.

Also, will this cause build errors if I don't have the needed patchs
that are in the DRM tree in my tree?

thanks,

greg k-h
