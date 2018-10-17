From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 17 Oct 2018 10:49:49 -0700
Subject: [PATCH v2 05/22] clk: at91: generated: set audio_pll_allowed in
 at91_clk_register_generated()
In-Reply-To: <20181016142200.19741-6-alexandre.belloni@bootlin.com>
References: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
 <20181016142200.19741-6-alexandre.belloni@bootlin.com>
Message-ID: <153979858914.5275.16522645452377539139@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Alexandre Belloni (2018-10-16 07:21:43)
> Set gck->audio_pll_allowed in at91_clk_register_generated. This makes it
> easier to do it from code that is not parsing device tree.
> 
> Also, this fixes an issue where the resulting clk_hw can be dereferenced
> before being tested for error.
> 
> Fixes: 1a1a36d72e3d ("clk: at91: clk-generated: make gclk determine audio_pll rate")
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next
