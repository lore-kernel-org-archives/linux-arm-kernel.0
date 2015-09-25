From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 25 Sep 2015 22:26:18 +0100
Subject: [PATCH linux-next v10 1/3] mfd: atmel-flexcom: create include
 file with macros used by DT bindings
In-Reply-To: <af5839d98ab0259b92b905f3403e224d62bfc787.1443087121.git.cyrille.pitchen@atmel.com>
References: <cover.1443087121.git.cyrille.pitchen@atmel.com>
 <af5839d98ab0259b92b905f3403e224d62bfc787.1443087121.git.cyrille.pitchen@atmel.com>
Message-ID: <20150925212618.GM27197@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 24 Sep 2015, Cyrille Pitchen wrote:

> This patch defines some macros to be used as value for the
> "atmel,flexcom-mode" DT property. This value is then written into
> the Operating Mode (OPMODE) bit field of the Flexcom Mode Register.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  include/dt-bindings/mfd/atmel-flexcom.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 include/dt-bindings/mfd/atmel-flexcom.h
> 
> diff --git a/include/dt-bindings/mfd/atmel-flexcom.h b/include/dt-bindings/mfd/atmel-flexcom.h
> new file mode 100644
> index 000000000000..6728f2851b4d
> --- /dev/null
> +++ b/include/dt-bindings/mfd/atmel-flexcom.h
> @@ -0,0 +1,16 @@
> +/*
> + * This header provides macros for Atmel Flexcom DT bindings.
> + *
> + * Copyright (C) 2015 Cyrille Pitchen <cyrille.pitchen@atmel.com>
> + *
> + * GPLv2 only

I'm not sure this constitutes as a proper licence statement.

> + */
> +
> +#ifndef __DT_BINDINGS_ATMEL_FLEXCOM_H__
> +#define __DT_BINDINGS_ATMEL_FLEXCOM_H__
> +
> +#define ATMEL_FLEXCOM_MODE_USART	1
> +#define ATMEL_FLEXCOM_MODE_SPI		2
> +#define ATMEL_FLEXCOM_MODE_TWI		3
> +
> +#endif /* __DT_BINDINGS_ATMEL_FLEXCOM_H__ */

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
