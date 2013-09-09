From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 09 Sep 2013 16:39:04 -0700
Subject: [PATCHv2 2/2] ARM: msm: Create a common board-dt and config
 ARCH_MSM_DT
In-Reply-To: <1378769094-14042-2-git-send-email-rvaswani@codeaurora.org>
References: <1378769094-14042-1-git-send-email-rvaswani@codeaurora.org>
 <1378769094-14042-2-git-send-email-rvaswani@codeaurora.org>
Message-ID: <522E5C18.7040007@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/13 16:24, Rohit Vaswani wrote:
> diff --git a/arch/arm/mach-msm/board-dt.c b/arch/arm/mach-msm/board-dt.c
> new file mode 100644
> index 0000000..16e6183
> --- /dev/null
> +++ b/arch/arm/mach-msm/board-dt.c
> @@ -0,0 +1,32 @@
> +/* Copyright (c) 2010-2012,2013 The Linux Foundation. All rights reserved.

Hm.. I meant 2010-2013. Maybe David can fix that when he picks it up.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
