From: robh@kernel.org (Rob Herring)
Date: Thu, 18 May 2017 08:01:53 -0500
Subject: [PATCH 2/2] arm64: defconfig: enable options needed for QCom
 DB410c board
In-Reply-To: <20170517215230.15108-2-robh@kernel.org>
References: <20170517215230.15108-1-robh@kernel.org>
 <20170517215230.15108-2-robh@kernel.org>
Message-ID: <CAL_JsqK3jkQawSLigy1hMDTc5M6VSSsUomjMom-WFSKtWJzjsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 17, 2017 at 4:52 PM, Rob Herring <robh@kernel.org> wrote:
> Enable Qualcomm drivers needed to boot Dragonboard 410c with HDMI. This
> enables support for clocks, regulators, and USB PHY.
>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm64/configs/defconfig | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index d916fc316698..5b94e3d24c16 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -303,6 +303,7 @@ CONFIG_MFD_CROS_EC_I2C=y
>  CONFIG_MFD_EXYNOS_LPASS=m
>  CONFIG_MFD_HI655X_PMIC=y
>  CONFIG_MFD_MAX77620=y
> +CONFIG_MFD_QCOM_RPM=y

According to Bjorn, this one is for 8064, so this hunk can be dropped.

>  CONFIG_MFD_SPMI_PMIC=y
>  CONFIG_MFD_RK808=y
>  CONFIG_MFD_SEC_CORE=y
