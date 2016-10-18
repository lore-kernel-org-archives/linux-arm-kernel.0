From: patrice.chotard@st.com (Patrice Chotard)
Date: Tue, 18 Oct 2016 09:50:13 +0200
Subject: [PATCH 04/19] MAINTAINERS: Remove phy-stih41x-usb.c entry from
 STi arch
In-Reply-To: <1473859677-9231-5-git-send-email-peter.griffin@linaro.org>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
 <1473859677-9231-5-git-send-email-peter.griffin@linaro.org>
Message-ID: <4108140b-ac27-42e6-8c25-d65caff70e12@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On 09/14/2016 03:27 PM, Peter Griffin wrote:
> Remove this driver as the IP is only found on STiH415/6
> silicon, and support for these SoC's is being removed
> from the kernel.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Cc: <kishon@ti.com>

Acked-by: Patrice Chotard <patrice.chotard@st.com>

Applied on sti-dt-for-4.10 branch

Thanks 

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 12c271c..6a278b9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1755,7 +1755,6 @@ F:	drivers/media/platform/sti/c8sectpfe/
>  F:	drivers/mmc/host/sdhci-st.c
>  F:	drivers/phy/phy-miphy28lp.c
>  F:	drivers/phy/phy-stih407-usb.c
> -F:	drivers/phy/phy-stih41x-usb.c
>  F:	drivers/pinctrl/pinctrl-st.c
>  F:	drivers/remoteproc/st_remoteproc.c
>  F:	drivers/reset/sti/
> 
