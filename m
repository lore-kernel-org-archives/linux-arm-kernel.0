From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 1 Oct 2015 10:36:30 -0700
Subject: [PATCH] arm: dts: qcom: Add #power-domain-cells property
In-Reply-To: <1443691562-16963-1-git-send-email-rnayak@codeaurora.org>
References: <1443691562-16963-1-git-send-email-rnayak@codeaurora.org>
Message-ID: <20151001173630.GC19319@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/01, Rajendra Nayak wrote:
> clock controller nodes which also support power domains (gdscs') need
> to have a #power-domain-cells property. Add these for gcc and mmcc
> nodes of msm8974, gcc of apq8084 and msm8916.
> Also update gcc and mmcc bindings for it.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
