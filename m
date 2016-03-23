From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 23 Mar 2016 15:33:32 -0700
Subject: [PATCH 15/17] qcom: ipq4019: add cpu operating points for cpufreq
 support
In-Reply-To: <1458770712-10880-16-git-send-email-mmcclint@codeaurora.org>
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
 <1458770712-10880-16-git-send-email-mmcclint@codeaurora.org>
Message-ID: <56F319BC.5050405@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/23/2016 03:05 PM, Matthew McClintock wrote:
> This adds some operating points for cpu frequeny scaling
>
> Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
> ---

Can you use the v2 OPP bindings instead? I imagine uV could be left out
then because there isn't any regulator control?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
