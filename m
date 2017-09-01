From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 1 Sep 2017 15:55:12 -0700
Subject: [PATCH v5 2/7] dt-bindings: clk: at91: add audio plls to the
 compatible list
In-Reply-To: <09230b9714c7d8fee053d1b014ef6af43c1bebbc.1502346448.git-series.quentin.schulz@free-electrons.com>
References: <cover.ada7bc60e0b3a0f7429afc6ea9e4869131d1b757.1502346448.git-series.quentin.schulz@free-electrons.com>
 <09230b9714c7d8fee053d1b014ef6af43c1bebbc.1502346448.git-series.quentin.schulz@free-electrons.com>
Message-ID: <20170901225512.GD21656@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10, Quentin Schulz wrote:
> This new clock driver set allows to have a fractional divided clock that
> would generate a precise clock particularly suitable for audio
> applications.
> 
> The main audio pll clock has two children clocks: one that is connected
> to the PMC, the other that can directly drive a pad. As these two routes
> have different enable bits and different dividers and divider formulas,
> they are handled by two different drivers.
> 
> This adds the audio plls (frac, pad and pmc) to the compatible list of
> at91 clocks in DT binding.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
