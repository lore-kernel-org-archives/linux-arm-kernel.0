From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 19 May 2015 18:45:08 -0700
Subject: [PATCH v2 2/2] clk: mmp: add PXA1928 clock support
In-Reply-To: <1431383120-16957-2-git-send-email-robh@kernel.org>
References: <1431383120-16957-1-git-send-email-robh@kernel.org>
 <1431383120-16957-2-git-send-email-robh@kernel.org>
Message-ID: <20150520014508.GC4815@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11, Rob Herring wrote:
> Add initial clock support for Marvell PXA1928. The PXA1928 is a mobile
> SOC and is similar to other MMP/PXA series of SOCs, so a lot of the
> existing infrastructure is reused here.
> 
> Currently the PLLs are just fixed clocks, and not all leaf clocks are
> implemented.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Mike Turquette <mturquette@linaro.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
