From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 11 Aug 2016 11:38:10 +0200
Subject: [PATCH V5 1/4] drm/imx-ldb: Add support to drm-bridge
In-Reply-To: <1d76685746a1524127aa6747994dd8fd84ad1c38.1470739193.git.peter.senna@collabora.com>
References: <1464626385-19253-1-git-send-email-peter.senna@collabora.com>
 <cover.1470739193.git.peter.senna@collabora.com>
 <1d76685746a1524127aa6747994dd8fd84ad1c38.1470739193.git.peter.senna@collabora.com>
Message-ID: <1470908290.2493.37.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, den 09.08.2016, 18:41 +0200 schrieb Peter Senna Tschudin:
> Add support to attach a drm_bridge to imx-ldb in addition to
> existing support to attach a LVDS panel.
> 
> This patch does a simple code refactoring by moving code
> from for_each_child_of_node iterator to a new function named
> imx_ldb_panel_ddc(). This was necessary to allow the panel ddc
> code to run only when the imx_ldb is not attached to a bridge.
> 
> Cc: Martyn Welch <martyn.welch@collabora.co.uk>
> Cc: Martin Donnelly <martin.donnelly@ge.com>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Peter Senna Tschudin <peter.senna@collabora.com>
> ---
> Unchanged from V4

I've rebased and applied patch 1.

thanks
Philipp
