From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 23 Jan 2013 08:48:02 +0100
Subject: [PATCH 0/4] TI LCDC DRM driver
In-Reply-To: <1358894185-21617-1-git-send-email-robdclark@gmail.com>
References: <1358894185-21617-1-git-send-email-robdclark@gmail.com>
Message-ID: <20130123074802.GT1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Tue, Jan 22, 2013 at 04:36:21PM -0600, Rob Clark wrote:
> 
>  drivers/gpu/drm/Kconfig                |   2 +
>  drivers/gpu/drm/Makefile               |   1 +
>  drivers/gpu/drm/i2c/Makefile           |   3 +
>  drivers/gpu/drm/i2c/tda998x_drv.c      | 908 +++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/tilcdc/Kconfig         |  25 +
>  drivers/gpu/drm/tilcdc/Makefile        |  10 +
>  drivers/gpu/drm/tilcdc/tilcdc_crtc.c   | 597 ++++++++++++++++++++++
>  drivers/gpu/drm/tilcdc/tilcdc_drv.c    | 611 ++++++++++++++++++++++
>  drivers/gpu/drm/tilcdc/tilcdc_drv.h    | 159 ++++++
>  drivers/gpu/drm/tilcdc/tilcdc_panel.c  | 443 ++++++++++++++++
>  drivers/gpu/drm/tilcdc/tilcdc_panel.h  |  26 +
>  drivers/gpu/drm/tilcdc/tilcdc_regs.h   | 154 ++++++
>  drivers/gpu/drm/tilcdc/tilcdc_slave.c  | 380 ++++++++++++++
>  drivers/gpu/drm/tilcdc/tilcdc_slave.h  |  26 +
>  drivers/gpu/drm/tilcdc/tilcdc_tfp410.c | 423 +++++++++++++++
>  drivers/gpu/drm/tilcdc/tilcdc_tfp410.h |  26 +
>  16 files changed, 3794 insertions(+)
>  create mode 100644 drivers/gpu/drm/i2c/tda998x_drv.c
>  create mode 100644 drivers/gpu/drm/tilcdc/Kconfig
>  create mode 100644 drivers/gpu/drm/tilcdc/Makefile
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_crtc.c
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_drv.c
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_drv.h
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_panel.c
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_panel.h
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_regs.h
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave.c
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_slave.h
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_tfp410.c
>  create mode 100644 drivers/gpu/drm/tilcdc/tilcdc_tfp410.h

I'm missing Documentation/devicetree/bindings/drm/tilcdc/ in the
diffstat. This is required for adding devicetree bindings.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
