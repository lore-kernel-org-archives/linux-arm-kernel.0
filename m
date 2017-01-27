From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 27 Jan 2017 10:48:09 -0800
Subject: [PATCHv5 1/5] clk: mvebu: support for 98DX3236 SoC
In-Reply-To: <20170127032546.14657-2-chris.packham@alliedtelesis.co.nz>
References: <20170127032546.14657-1-chris.packham@alliedtelesis.co.nz>
 <20170127032546.14657-2-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170127184809.GE8801@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27, Chris Packham wrote:
> The 98DX3236, 98DX3336, 98DX4521 and variants have a different TCLK from
> the Armada XP (200MHz vs 250MHz). The CPU core clock is fixed at 800MHz.
> 
> The clock gating options are a subset of those on the Armada XP.
> 
> The core clock divider is different to the Armada XP also.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
