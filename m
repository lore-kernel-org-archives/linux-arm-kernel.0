From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 30 Aug 2016 11:25:03 +0100
Subject: [PATCH v8 09/18] ARM: multi_v7_defconfig: Enable STi and
 simple-card drivers.
In-Reply-To: <1472223413-7254-10-git-send-email-peter.griffin@linaro.org>
References: <1472223413-7254-1-git-send-email-peter.griffin@linaro.org>
 <1472223413-7254-10-git-send-email-peter.griffin@linaro.org>
Message-ID: <20160830102503.GV1661@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nit: Remove full-stop from $SUBJECT

On Fri, 26 Aug 2016, Peter Griffin wrote:
> This patch enables the STi ALSA drivers found on STi platforms
> as well as the simple-card driver which is a dependency to have
> working sound.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Cc: arnaud.pouliquen at st.com
> Cc: broonie at kernel.org
> ---
>  arch/arm/configs/multi_v7_defconfig | 3 +++
>  1 file changed, 3 insertions(+)

Acked-by: Lee Jones <lee.jones@linaro.org>
  
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 998578a..51a38b1 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -644,6 +644,9 @@ CONFIG_SND_SOC_AK4642=m
>  CONFIG_SND_SOC_SGTL5000=m
>  CONFIG_SND_SOC_SPDIF=m
>  CONFIG_SND_SOC_WM8978=m
> +CONFIG_SND_SOC_STI=m
> +CONFIG_SND_SOC_STI_SAS=m
> +CONFIG_SND_SIMPLE_CARD=m
>  CONFIG_USB=y
>  CONFIG_USB_XHCI_HCD=y
>  CONFIG_USB_XHCI_MVEBU=y

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
