From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 1 Sep 2017 15:55:23 -0700
Subject: [PATCH v5 6/7] ASoC: atmel-classd: remove aclk clock from DT
 binding
In-Reply-To: <baa9ebcc16cba5f41ee5b01895ec7cfce60a8ddc.1502346448.git-series.quentin.schulz@free-electrons.com>
References: <cover.ada7bc60e0b3a0f7429afc6ea9e4869131d1b757.1502346448.git-series.quentin.schulz@free-electrons.com>
 <baa9ebcc16cba5f41ee5b01895ec7cfce60a8ddc.1502346448.git-series.quentin.schulz@free-electrons.com>
Message-ID: <20170901225523.GH21656@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10, Quentin Schulz wrote:
> Since gclk (generated-clk) is now able to determine the rate of the
> audio_pll, there is no need for classd to have a direct phandle to the
> audio_pll while already having a phandle to gclk.
> 
> This binding is used by no board in mainline so it is safe to be
> modified.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
