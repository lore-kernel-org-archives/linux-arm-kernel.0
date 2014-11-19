From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 19 Nov 2014 10:45:15 +0000
Subject: [PATCH] MAINTAINERS: Add ahci_st.c to ARCH/STI architecture
In-Reply-To: <1416386694-7402-1-git-send-email-peter.griffin@linaro.org>
References: <1416386694-7402-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <20141119104515.GJ13959@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 19 Nov 2014, Peter Griffin wrote:

> This patch adds the ahci_st.c driver found on STMicroelectronics
> stih41x consumer electronics SoC's into the STI arch section
> of the maintainers file.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/MAINTAINERS b/MAINTAINERS
> index a20df9b..2b0a53e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1430,6 +1430,7 @@ F:	drivers/tty/serial/st-asc.c
>  F:	drivers/usb/dwc3/dwc3-st.c
>  F:	drivers/usb/host/ehci-st.c
>  F:	drivers/usb/host/ohci-st.c
> +F:	drivers/ata/ahci_st.c
>  
>  ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT
>  M:	Lennert Buytenhek <kernel@wantstofly.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
