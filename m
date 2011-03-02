From: joe@perches.com (Joe Perches)
Date: Wed, 02 Mar 2011 14:50:13 -0800
Subject: [Qualcomm PM8921 MFD 5/6] MAINTAINERS: Add pmic8921, pmic8xxx
	subdevices maintainers
In-Reply-To: <1299104001-5240-6-git-send-email-adharmap@codeaurora.org>
References: <1299104001-5240-1-git-send-email-adharmap@codeaurora.org>
	<1299104001-5240-6-git-send-email-adharmap@codeaurora.org>
Message-ID: <1299106213.4208.112.camel@Joe-Laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-03-02 at 14:13 -0800, adharmap at codeaurora.org wrote:
> diff --git a/MAINTAINERS b/MAINTAINERS

The patch subject is not quite correct.
You're adding patterns, not maintainers.

> index 696cb18..97107fd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -905,6 +905,12 @@ F:	drivers/mmc/host/msm_sdcc.h
>  F:	drivers/tty/serial/msm_serial.h
>  F:	drivers/tty/serial/msm_serial.c
>  F:	drivers/platform/msm/
> +F:	drivers/mfd/pm8921-core.c
> +F:	drivers/mfd/pm8xxx-mpp.c
> +F:	include/linux/mfd/pm8921.h
> +F:	include/linux/mfd/pm8xxx/
> +F:	drivers/gpio/pm8xxx-gpio.c
> +F:	drivers/mfd/pm8xxx-irq.c

My preference is to keep these in alphabetic order.

Another option is a wildcard pattern match like:

F:	drivers/*/pm8???-*

instead of:

F:	drivers/gpio/pm8xxx-gpio.c
F:	drivers/mfd/pm8921-core.c
F:	drivers/mfd/pm8xxx-irq.c
F:	drivers/mfd/pm8xxx-mpp.c
