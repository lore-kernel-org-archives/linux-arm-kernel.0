From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 6 Nov 2014 12:29:31 +0530
Subject: [PATCH v5 2/8] phy: miphy28lp: Add PHY header file for DT x Driver
 defines
In-Reply-To: <1415098284-11182-3-git-send-email-gabriel.fernandez@linaro.org>
References: <1415098284-11182-1-git-send-email-gabriel.fernandez@linaro.org>
 <1415098284-11182-3-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <545B1C53.9010406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 04 November 2014 04:21 PM, Gabriel FERNANDEZ wrote:
> This provides the shared header file which will be reference from both
> PHY driver and its associated Device Tree node(s).
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> ---
>  include/dt-bindings/phy/phy.h | 18 ++++++++++++++++++

I don't see this being used in device tree file. Are you planning to add this
after -rc1 is tagged. Or else I have to create a separate branch for this file
which will be merged by both me and the dt maintainer. Let me know.

Thanks
Kishon
>  1 file changed, 18 insertions(+)
>  create mode 100644 include/dt-bindings/phy/phy.h
> 
> diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
> new file mode 100644
> index 0000000..e8c6a3f
> --- /dev/null
> +++ b/include/dt-bindings/phy/phy.h
> @@ -0,0 +1,18 @@
> +/*
> + *
> + * This header provides constants for the phy framework
> + *
> + * Copyright (C) 2014 STMicroelectronics
> + * Author: Gabriel Fernandez <gabriel.fernandez@st.com>
> + * License terms:  GNU General Public License (GPL), version 2
> + */
> +
> +#ifndef _DT_BINDINGS_PHY
> +#define _DT_BINDINGS_PHY
> +
> +#define PHY_TYPE_SATA		1
> +#define PHY_TYPE_PCIE		2
> +#define PHY_TYPE_USB2		3
> +#define PHY_TYPE_USB3		4
> +
> +#endif /* _DT_BINDINGS_PHY */
> 
