From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 27 Nov 2013 19:54:24 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzNdIHB3bTogQWRkIG1jMTN4eHggcHdtIGRyaXZlci4=?=
In-Reply-To: <1385566771-366-1-git-send-email-denis@eukrea.com>
References: <1385566771-366-1-git-send-email-denis@eukrea.com>
Message-ID: <1385567664.228570055@f131.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

...
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  .../devicetree/bindings/pwm/fsl,mc13xxx-pwm.txt    |   19 ++
>  drivers/mfd/mc13xxx-core.c                         |   11 ++
>  drivers/pwm/Kconfig                                |    6 +
>  drivers/pwm/Makefile                               |    1 +
>  drivers/pwm/pwm-mc13xxx.c                          |  205 ++++++++++++++++++++
>  include/linux/mfd/mc13783.h                        |    2 +
>  6 files changed, 244 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/fsl,mc13xxx-pwm.txt
>  create mode 100644 drivers/pwm/pwm-mc13xxx.c
> 
> diff --git a/Documentation/devicetree/bindings/pwm/fsl,mc13xxx-pwm.txt b/Documentation/devicetree/bindings/pwm/fsl,mc13xxx-pwm.txt
> new file mode 100644
> index 0000000..a1394d0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/fsl,mc13xxx-pwm.txt
> @@ -0,0 +1,19 @@
> +Freescale mc13xxx series PWM drivers.
> +
> +Supported PWMs:
> +mc13892 series
> +mc34708 series

MC13892 does not have a dedicated PWM.
You can probably use the existing driver mc13xxx-led driver.

---
