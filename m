From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 05 May 2014 09:57:11 +0200
Subject: [PATCH 3/4] misc: exynos-chipid: Add Exynos Chipid driver support
In-Reply-To: <1399097500-4052-4-git-send-email-pankaj.dubey@samsung.com>
References: <1399097500-4052-1-git-send-email-pankaj.dubey@samsung.com>
 <1399097500-4052-4-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1399276631.15737.1.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On sob, 2014-05-03 at 15:11 +0900, Pankaj Dubey wrote:
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 7eb4b69..48c8fb5 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -55,3 +55,4 @@ obj-$(CONFIG_SRAM)		+= sram.o
>  obj-y				+= mic/
>  obj-$(CONFIG_GENWQE)		+= genwqe/
>  obj-$(CONFIG_ECHO)		+= echo/
> +obj-$(CONFIG_EXYNOS_CHIPID)	+= exynos-chipid.o
> diff --git a/drivers/misc/exynos-chipid.c b/drivers/misc/exynos-chipid.c
> new file mode 100644
> index 0000000..eb23339
> --- /dev/null
> +++ b/drivers/misc/exynos-chipid.c
> @@ -0,0 +1,83 @@
> +/*
> + * Copyright (c) 2014-2015 Samsung Electronics Co., Ltd.
> + *	      http://www.samsung.com/

I wonder why this is copyrighted in the future (2015)?

Best regards,
Krzysztof
