From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 26 Mar 2015 20:08:56 +0000
Subject: [PATCHv2 1/2] mfd: devicetree: qcom_rpm: document IPQ8064
 resources
In-Reply-To: <1427394566-24327-2-git-send-email-sboyd@codeaurora.org>
References: <1427394566-24327-1-git-send-email-sboyd@codeaurora.org>
 <1427394566-24327-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150326200856.GS5951@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Mar 2015, Stephen Boyd wrote:

> From: Josh Cartwright <joshc@codeaurora.org>
> 
> The IPQ8064 SoC has several RPM-controlled resources, an NSS fabrick
> clock and four regulator resources.  Provide definitions for them.
> 
> Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
> [sboyd at codeaurora.org: Drop regulator part of binding]
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom-rpm.txt | 1 +
>  include/dt-bindings/mfd/qcom-rpm.h                 | 6 ++++++
>  2 files changed, 7 insertions(+)

Thanks for re-basing.  Patch applied.

> diff --git a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
> index 85e31980017a..94d9ae8d5168 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
> +++ b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
> @@ -12,6 +12,7 @@ frequencies.
>  		    "qcom,rpm-apq8064"
>  		    "qcom,rpm-msm8660"
>  		    "qcom,rpm-msm8960"
> +		    "qcom,rpm-ipq8064"
>  
>  - reg:
>  	Usage: required
> diff --git a/include/dt-bindings/mfd/qcom-rpm.h b/include/dt-bindings/mfd/qcom-rpm.h
> index 388a6f3d6165..13a9d4bf2662 100644
> --- a/include/dt-bindings/mfd/qcom-rpm.h
> +++ b/include/dt-bindings/mfd/qcom-rpm.h
> @@ -141,6 +141,12 @@
>  #define QCOM_RPM_SYS_FABRIC_MODE		131
>  #define QCOM_RPM_USB_OTG_SWITCH			132
>  #define QCOM_RPM_VDDMIN_GPIO			133
> +#define QCOM_RPM_NSS_FABRIC_0_CLK		134
> +#define QCOM_RPM_NSS_FABRIC_1_CLK		135
> +#define QCOM_RPM_SMB208_S1a			136
> +#define QCOM_RPM_SMB208_S1b			137
> +#define QCOM_RPM_SMB208_S2a			138
> +#define QCOM_RPM_SMB208_S2b			139
>  
>  /*
>   * Constants used to select force mode for regulators.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
