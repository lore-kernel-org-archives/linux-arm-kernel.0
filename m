From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 11 May 2015 21:01:37 +0800
Subject: [PATCH] ARM: dts: imx6qdl: Add power-domain phandle to CODA
 device node
In-Reply-To: <1431005056-10575-1-git-send-email-p.zabel@pengutronix.de>
References: <1431005056-10575-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20150511130137.GF9347@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 07, 2015 at 03:24:16PM +0200, Philipp Zabel wrote:
> The CODA960 VPU is part of the PU power domain. Add power-domains
> phandle so it can be associated with the PU generic pm domain for
> power gating.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied, thanks.
