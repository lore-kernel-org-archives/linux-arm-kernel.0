From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 10 Jul 2013 23:37:06 +0800
Subject: [PATCH v3] ARM: imx: Select MIGHT_HAVE_CACHE_L2X0
In-Reply-To: <1373470216-12996-1-git-send-email-fabio.estevam@freescale.com>
References: <1373470216-12996-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20130710153704.GD24654@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 10, 2013 at 12:30:16PM -0300, Fabio Estevam wrote:
> Select MIGHT_HAVE_CACHE_L2X0 for armv6 and armv7 i.MX SoCs.
> 
> By selecting MIGHT_HAVE_CACHE_L2X0, the user still has the possibility to 
> disable CACHE_L2X0 selection via menuconfig.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
