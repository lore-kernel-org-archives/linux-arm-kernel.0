From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Mon, 19 Nov 2018 19:05:11 +0200
Subject: [PATCH v2 6/9] phy: Move Allwinner A31 D-PHY driver to
 drivers/phy/
In-Reply-To: <c3fe50ce10d514c15eb4b3e4abec94a7ef15538c.1541516029.git-series.maxime.ripard@bootlin.com>
References: <cover.c2c2ae47383b9dbbdee6b69cafdd7391c06dde4f.1541516029.git-series.maxime.ripard@bootlin.com>
 <c3fe50ce10d514c15eb4b3e4abec94a7ef15538c.1541516029.git-series.maxime.ripard@bootlin.com>
Message-ID: <20181119170511.4yhvpfa7uiybgvty@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Tue, Nov 06, 2018 at 03:54:18PM +0100, Maxime Ripard wrote:
> Now that our MIPI D-PHY driver has been converted to the phy framework,
> let's move it into the drivers/phy directory.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  drivers/gpu/drm/sun4i/Kconfig               |  10 +-
>  drivers/gpu/drm/sun4i/Makefile              |   1 +-
>  drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c     | 318 +---------------------
>  drivers/phy/allwinner/Kconfig               |  12 +-
>  drivers/phy/allwinner/Makefile              |   1 +-
>  drivers/phy/allwinner/phy-sun6i-mipi-dphy.c | 318 +++++++++++++++++++++-
>  6 files changed, 332 insertions(+), 328 deletions(-)
>  delete mode 100644 drivers/gpu/drm/sun4i/sun6i_mipi_dphy.c
>  create mode 100644 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c

Could you use git format-patch -M option on the next time, please?

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi
