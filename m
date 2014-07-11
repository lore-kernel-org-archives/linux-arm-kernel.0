From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Fri, 11 Jul 2014 11:07:10 +0200
Subject: [PATCH v3 2/5] phy: miphy365x: Add MiPHY365x header file for DT x
 Driver defines
In-Reply-To: <1404906074-31992-3-git-send-email-lee.jones@linaro.org>
References: <1404906074-31992-1-git-send-email-lee.jones@linaro.org>
 <1404906074-31992-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CAG374jD=DOVveEOxvddxMZYrEk0Paj4on3cnzSM8kZstSUrwcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee

On 9 July 2014 13:41, Lee Jones <lee.jones@linaro.org> wrote:
> This provides the shared header file which will be reference from both
> the MiPHY365x driver and its associated Device Tree node(s).
>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Alexandre Torgue <alexandre.torgue@st.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  include/dt-bindings/phy/phy-miphy365x.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 include/dt-bindings/phy/phy-miphy365x.h
>
> diff --git a/include/dt-bindings/phy/phy-miphy365x.h b/include/dt-bindings/phy/phy-miphy365x.h
> new file mode 100644
> index 0000000..8ef8aba
> --- /dev/null
> +++ b/include/dt-bindings/phy/phy-miphy365x.h
> @@ -0,0 +1,14 @@
> +/*
> + * This header provides constants for the phy framework
> + * based on the STMicroelectronics MiPHY365x.
> + *
> + * Author: Lee Jones <lee.jones@linaro.org>
> + */
> +#ifndef _DT_BINDINGS_PHY_MIPHY
> +#define _DT_BINDINGS_PHY_MIPHY
> +
> +#define MIPHY_TYPE_SATA                1

why it start to 1 ? for my side i prefer 0.

BR.

Gabriel.

> +#define MIPHY_TYPE_PCIE                2
> +#define MIPHY_TYPE_USB         3
> +
> +#endif /* _DT_BINDINGS_PHY_MIPHY */
> --
> 1.8.3.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
