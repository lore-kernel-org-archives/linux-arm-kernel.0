From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 9 Oct 2013 09:38:53 +0800
Subject: [PATCH] ARM: dts: imx51-babbage: Make DVI and WVGA panel
 functional
In-Reply-To: <1381258332-6208-1-git-send-email-fabio.estevam@freescale.com>
References: <1381258332-6208-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20131009013850.GC8946@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 08, 2013 at 03:52:12PM -0300, Fabio Estevam wrote:
> Currently we get the following errors on imx51-babbage:
> 
> /display at di0: could not find display-timings node
> /display at di0: no timings specified
> /display at di1: could not find display-timings node
> /display at di1: no timings specified
> imx-drm imx-drm: failed to allocate buffer with size 0
> 
> Provide timing values for IPU1, which is connected to a DVI bridge and
> to IPU2, which can be connected to the WVGA panel, so that both of them can
> be functional.
> 
> While at it, disable the WVGA panel, so that DVI output becomes the default one.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
