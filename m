From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 17 Oct 2018 10:49:30 -0700
Subject: [PATCH v2 01/22] clk: at91: audio-pll: fix audio pmc type
In-Reply-To: <20181016142200.19741-2-alexandre.belloni@bootlin.com>
References: <20181016142200.19741-1-alexandre.belloni@bootlin.com>
 <20181016142200.19741-2-alexandre.belloni@bootlin.com>
Message-ID: <153979857072.5275.3162831436786210773@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Alexandre Belloni (2018-10-16 07:21:39)
> The allocation for the audio pmc is using the size of struct clk_audio_pad
> instead of struct clk_audio_pmc. This works fine because the former is
> larger than the latter but it is safer to be correct.
> 
> Fixes: ("0865805d82d4 clk: at91: add audio pll clock drivers")
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next
