From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 7 Feb 2014 19:26:07 -0800
Subject: [PATCH v3 3/5] ARM: qcom: Split Qualcomm support into legacy
 and multiplatform
In-Reply-To: <1391725484-6673-4-git-send-email-galak@codeaurora.org>
References: <1391725484-6673-1-git-send-email-galak@codeaurora.org>
 <1391725484-6673-4-git-send-email-galak@codeaurora.org>
Message-ID: <20140208032607.GC10784@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06, Kumar Gala wrote:
> diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-qcom/platsmp.c
> similarity index 98%
> rename from arch/arm/mach-msm/platsmp.c
> rename to arch/arm/mach-qcom/platsmp.c
> index 251a91e..67823a7 100644
> --- a/arch/arm/mach-msm/platsmp.c
> +++ b/arch/arm/mach-qcom/platsmp.c
> @@ -2,6 +2,7 @@
>   *  Copyright (C) 2002 ARM Ltd.
>   *  All Rights Reserved
>   *  Copyright (c) 2010, Code Aurora Forum. All rights reserved.
> + *  Copyright (c) 2014 The Linux Foundation. All rights reserved.

We should replace the Code Aurora Forum copyright with Linux
Foundation here.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
