From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 7 Oct 2015 23:12:43 -0700
Subject: [PATCH v3 5/9] thermal: qcom: tsens-8960: Add support for 8960
 family of SoCs
In-Reply-To: <1444280468-17159-6-git-send-email-rnayak@codeaurora.org>
References: <1444280468-17159-1-git-send-email-rnayak@codeaurora.org>
 <1444280468-17159-6-git-send-email-rnayak@codeaurora.org>
Message-ID: <20151008061243.GE26883@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08, Rajendra Nayak wrote:
> diff --git a/drivers/thermal/qcom/Makefile b/drivers/thermal/qcom/Makefile
> index a471100..f3cefd1 100644
> --- a/drivers/thermal/qcom/Makefile
> +++ b/drivers/thermal/qcom/Makefile
> @@ -1,2 +1,2 @@
>  obj-$(CONFIG_QCOM_TSENS)	+= qcom_tsens.o
> -qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o
> +qcom_tsens-y			+= tsens.o tsens-common.o tsens-8916.o tsens-8974.o tsens-8960.o

Maybe a dumb question: What's the point of multiple files for
each SoC if they're always built?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
