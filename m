From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Thu, 8 Feb 2018 16:14:28 +0100
Subject: [PATCH v2] drm/bridge/synopsys: dsi: Adopt SPDX identifiers
In-Reply-To: <20180208145805.24762-1-philippe.cornu@st.com>
References: <20180208145805.24762-1-philippe.cornu@st.com>
Message-ID: <CAOFm3uFQYjTZxX7Ozf7CJMDof=pretbk4cKGFf0BtwWh0SXrfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 8, 2018 at 3:58 PM, Philippe Cornu <philippe.cornu@st.com> wrote:
> Add SPDX identifiers to the Synopsys DesignWare MIPI DSI
> host controller driver.
>
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
> Changes in v2: Update to "GPL-2.0+" following comments from Laurent
> Pinchart, Benjamin Gaignard & Philippe Ombredanne.
>
>  drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> index 7bac101c285c..99f0e4f51716 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> @@ -1,12 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
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
> --
> 2.15.1
>

Thank you.

Acked-by: Philippe Ombredanne <pombredanne@nexB.com>
