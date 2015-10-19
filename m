From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 19 Oct 2015 12:59:46 -0700
Subject: [PATCH 1/3] clk: samsung: exynos4: Add SSS gate clock
In-Reply-To: <1445230834-32689-2-git-send-email-k.kozlowski@samsung.com>
References: <1445230834-32689-1-git-send-email-k.kozlowski@samsung.com>
 <1445230834-32689-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20151019195946.GH10182@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19, Krzysztof Kozlowski wrote:
> Add a gate clock for controlling all clocks of Security Sub System
> (SSS).
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

The To: list is huge, so I have no idea if you want me to apply
this patch or not, and given that it's part of a series that has
dts changes I guess that means it should go through arm-soc:

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
