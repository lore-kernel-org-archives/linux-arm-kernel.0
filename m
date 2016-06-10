From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 10 Jun 2016 13:25:28 -0700
Subject: [PATCH 2/5] arm: defconfig: Enable PM8941 pwr key
In-Reply-To: <1463634020-17252-3-git-send-email-andy.gross@linaro.org>
References: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
 <1463634020-17252-3-git-send-email-andy.gross@linaro.org>
Message-ID: <20160610202528.GO1256@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 18 May 22:00 PDT 2016, Andy Gross wrote:

> This patch enables the PM8941 pwr key driver.
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 8917150..d4c539f 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -142,6 +142,8 @@ CONFIG_WL18XX=m
>  CONFIG_WLCORE_SDIO=m
>  CONFIG_INPUT_EVDEV=y
>  CONFIG_KEYBOARD_GPIO=y
> +CONFIG_INPUT_MISC=y
> +CONFIG_INPUT_PM8941_PWRKEY=y
>  # CONFIG_SERIO_SERPORT is not set
>  CONFIG_SERIO_AMBAKMI=y
>  CONFIG_LEGACY_PTY_COUNT=16
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
