From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 21 May 2014 10:18:53 -0500
Subject: [PATCH v1 3/4] ARM: qcom: Add APQ8084-MTP board to mach-qcom
In-Reply-To: <1400684225-21381-4-git-send-email-gdjakov@mm-sol.com>
References: <1400684225-21381-1-git-send-email-gdjakov@mm-sol.com>
 <1400684225-21381-4-git-send-email-gdjakov@mm-sol.com>
Message-ID: <A6B00F86-FFD3-4FEF-B39E-EAA511565B80@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On May 21, 2014, at 9:57 AM, Georgi Djakov <gdjakov@mm-sol.com> wrote:

> Add board compatibility string to the board machine descriptors.
> 
> Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
> ---
> arch/arm/mach-qcom/board.c |    1 +
> 1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-qcom/board.c b/arch/arm/mach-qcom/board.c
> index bae617e..ae0a405 100644
> --- a/arch/arm/mach-qcom/board.c
> +++ b/arch/arm/mach-qcom/board.c
> @@ -18,6 +18,7 @@ static const char * const qcom_dt_match[] __initconst = {
> 	"qcom,msm8660-surf",
> 	"qcom,msm8960-cdp",
> 	"qcom,apq8074-dragonboard",
> +	"qcom,apq8084-mtp",
> 	NULL
> };
> 
> -- 
> 1.7.9.5
> 

Let?s just make this ?qcom,apq8084? to cover other future apq8084 based boards.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
