From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 13 Apr 2016 11:21:56 -0700
Subject: [GIT PULL] Qualcomm Driver Updates for v4.7
In-Reply-To: <20160413181002.GH19945@localhost>
References: <1459540776-7056-1-git-send-email-andy.gross@linaro.org>
 <20160413181002.GH19945@localhost>
Message-ID: <20160413182156.GE14441@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/13, Olof Johansson wrote:
> THis does:
> 
> -config ARCH_MSM8974
> -       bool "Enable support for MSM8974"
> -       select HAVE_ARM_ARCH_TIMER
> 
> 
> ... and I don't see the HAVE_ARCH_ARM_TIMER added anywhere. So it looks
> like you might need to pick it for ARCH_QCOM_A_FAMILY now?
> 

That was part of the original series[1]. Splitting up patches
into topic branches is problematic here it seems.

[1] http://lkml.kernel.org/r/1448485478-21699-3-git-send-email-sboyd at codeaurora.org

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
