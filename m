From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 31 Mar 2015 21:45:45 +0530
Subject: [PATCH v2 6/6] MAINTAINERS: Add phy-miphy28lp.c to ARCH/STI
 architecture
In-Reply-To: <1427728632-10846-7-git-send-email-peter.griffin@linaro.org>
References: <1427728632-10846-1-git-send-email-peter.griffin@linaro.org>
 <1427728632-10846-7-git-send-email-peter.griffin@linaro.org>
Message-ID: <551AC831.2000108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 30 March 2015 08:47 PM, Peter Griffin wrote:
> This patch adds the phy-miphy28lp.c phy driver found on STMicroelectronics
> stih407 family SoC's into the STI arch section of the maintainers file.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1de6afa..fa1bb4f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1469,6 +1469,7 @@ F:	drivers/clocksource/arm_global_timer.c
>   F:	drivers/i2c/busses/i2c-st.c
>   F:	drivers/media/rc/st_rc.c
>   F:	drivers/mmc/host/sdhci-st.c
> +F:	drivers/phy/phy-miphy28lp.c

add for miphy365x.c as well?

-Kishon
