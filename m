From: robh@kernel.org (Rob Herring)
Date: Tue, 8 Sep 2015 18:33:19 -0500
Subject: [PATCH linux-next v9 1/3] mfd: atmel-flexcom: create include file
 with macros used by DT bindings
In-Reply-To: <69844d8092ccbcaef6a3a24d39127ca432462d69.1441118159.git.cyrille.pitchen@atmel.com>
References: <cover.1441118159.git.cyrille.pitchen@atmel.com>
 <69844d8092ccbcaef6a3a24d39127ca432462d69.1441118159.git.cyrille.pitchen@atmel.com>
Message-ID: <55EF703F.2030806@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/2015 09:46 AM, Cyrille Pitchen wrote:
> This patch defines some macros to be used as value for the
> "atmel,flexcom-mode" DT property. This value is then written into
> the Operating Mode (OPMODE) bit field of the Flexcom Mode Register.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>

Acked-by: Rob Herring <robh@kernel.org>

In the future, you can combine headers with the binding doc as they are
part of the binding.

Rob

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
> 
