From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 20 Aug 2014 20:23:23 +0530
Subject: [PATCH 2/5] phy: miphy28lp: Add MiPHY28lp header file for DT
 x Driver defines
In-Reply-To: <1407944075-8093-3-git-send-email-gabriel.fernandez@linaro.org>
References: <1407944075-8093-1-git-send-email-gabriel.fernandez@linaro.org>
 <1407944075-8093-3-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <53F4B663.90400@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 13 August 2014 09:04 PM, Gabriel FERNANDEZ wrote:
> This provides the shared header file which will be reference from both
> the MiPHY28lp driver and its associated Device Tree node(s).
> 
> Signed-off-by: alexandre torgue <alexandre.torgue@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> ---
>  include/dt-bindings/phy/phy-miphy28lp.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100644 include/dt-bindings/phy/phy-miphy28lp.h
> 
> diff --git a/include/dt-bindings/phy/phy-miphy28lp.h b/include/dt-bindings/phy/phy-miphy28lp.h
> new file mode 100644
> index 0000000..7cf9bce
> --- /dev/null
> +++ b/include/dt-bindings/phy/phy-miphy28lp.h
> @@ -0,0 +1,12 @@
> +/*
> + * This header provides constants for the phy framework
> + * based on the STMicroelectronics miph28lp.
> + */
> +#ifndef _DT_BINDINGS_PHY_MIPHY28LP
> +#define _DT_BINDINGS_PHY_MIPHY28LP
> +
> +#define MIPHY_TYPE_SATA		1
> +#define MIPHY_TYPE_PCIE		2
> +#define MIPHY_TYPE_USB		3

I think we should create a common file for phy so that all user's need not
create a separate copy of the same thing.

Thanks
Kishon
