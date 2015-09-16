From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 16 Sep 2015 15:30:51 -0700
Subject: [RESEND PATCH 0/2] ST PLL fixes for 4.3-rc2
In-Reply-To: <1442389379-9298-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1442389379-9298-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <20150916223051.GO23081@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/16, Gabriel Fernandez wrote:
> This patch set fixes a kernel crash :
[..]
> 
> This kernel crash is due to a broken compatibility with this commit:
> commit 5eb26c605909 ("ARM: STi: DT: Rename st_pll3200c32_407_c0_x into st_pll3200c32_cx_x")

It isn't clear who's supposed to apply this because the To: list
is huge. Did you want to take this through arm-soc? If so, feel
free to take my acked-by on the second patch. The first patch
doesn't even apply to clk tree because the patch introducing the
typo didn't go through our tree.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
