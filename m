From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 23 Jan 2018 01:30:51 +0200
Subject: [PATCH] drm/bridge/synopsys: dsi: Adopt SPDX identifiers
In-Reply-To: <20180122102608.12565-1-philippe.cornu@st.com>
References: <20180122102608.12565-1-philippe.cornu@st.com>
Message-ID: <3169703.7pajs7FEnH@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe,

Thank you for the patch.

On Monday, 22 January 2018 12:26:08 EET Philippe Cornu wrote:
> Add SPDX identifiers to the Synopsys DesignWare MIPI DSI
> host controller driver.
> 
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c index
> 46b0e73404d1..e06836dec77c 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -1,12 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0

According to Documentation/process/license-rules.txt this would change the 
existing license. The correct identifier is GPL-2.0+.

>  /*
>   * Copyright (c) 2016, Fuzhou Rockchip Electronics Co., Ltd
>   * Copyright (C) STMicroelectronics SA 2017
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
>   * Modified by Philippe Cornu <philippe.cornu@st.com>
>   * This generic Synopsys DesignWare MIPI DSI host driver is based on the
>   * Rockchip version from rockchip/dw-mipi-dsi.c with phy & bridge APIs.


-- 
Regards,

Laurent Pinchart
