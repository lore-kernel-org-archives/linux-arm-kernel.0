From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 21 Jul 2017 15:21:06 -0700
Subject: [PATCH v3 2/9] clk: at91: add audio plls to the compatible list
 in DT binding
In-Reply-To: <20170713074927.10882-3-quentin.schulz@free-electrons.com>
References: <20170713074927.10882-1-quentin.schulz@free-electrons.com>
 <20170713074927.10882-3-quentin.schulz@free-electrons.com>
Message-ID: <20170721222106.GP19878@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13, Quentin Schulz wrote:
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
> ---
> 
> added in v2:
>   - split from big patch with pll drivers and dt-binding

Subject seems wrong. Should have "bindings" somewhere?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
