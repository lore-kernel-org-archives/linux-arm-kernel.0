From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Feb 2016 11:00:46 +0800
Subject: [PATCH] ARM: dts: imx6q: add missing links between ipu2 and mipi
 dsi
In-Reply-To: <1456325566-20375-1-git-send-email-p.zabel@pengutronix.de>
References: <1456325566-20375-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20160229030045.GP22051@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2016 at 03:52:46PM +0100, Philipp Zabel wrote:
> The backlinks are already there since commit 4520e69238b3 ("ARM: dts:
> imx6qdl: Add IPU DI ports and endpoints, move imx-drm node to dtsi")
> and were moved by commit 70c2652c6c5b ("ARM: dts: imx6qdl: Move existing
> MIPI DSI ports into a new 'ports' node"), but the links from IPU2 DI0/1
> to the MIPI DSI mux are missing. Fix this.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied, thanks.
