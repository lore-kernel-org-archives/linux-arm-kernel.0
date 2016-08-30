From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 30 Aug 2016 11:27:33 +0100
Subject: [PATCH v8 02/18] MAINTAINERS: Add st slim core rproc driver to
 STi section.
In-Reply-To: <1472223413-7254-3-git-send-email-peter.griffin@linaro.org>
References: <1472223413-7254-1-git-send-email-peter.griffin@linaro.org>
 <1472223413-7254-3-git-send-email-peter.griffin@linaro.org>
Message-ID: <20160830102733.GB10121@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Aug 2016, Peter Griffin wrote:

> This patch adds the slim core rproc driver to the STi section
> of the MAINTAINERS file.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Lee Jones <lee.jones@linaro.org>
  
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0bbe4b1..5dd3b24 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1749,6 +1749,7 @@ F:	drivers/phy/phy-stih407-usb.c
>  F:	drivers/phy/phy-stih41x-usb.c
>  F:	drivers/pinctrl/pinctrl-st.c
>  F:	drivers/remoteproc/st_remoteproc.c
> +F:	drivers/remoteproc/st_slim_rproc.c
>  F:	drivers/reset/sti/
>  F:	drivers/rtc/rtc-st-lpc.c
>  F:	drivers/tty/serial/st-asc.c
> @@ -1757,6 +1758,7 @@ F:	drivers/usb/host/ehci-st.c
>  F:	drivers/usb/host/ohci-st.c
>  F:	drivers/watchdog/st_lpc_wdt.c
>  F:	drivers/ata/ahci_st.c
> +F:	include/linux/remoteproc/st_slim_rproc.h
>  
>  ARM/STM32 ARCHITECTURE
>  M:	Maxime Coquelin <mcoquelin.stm32@gmail.com>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
