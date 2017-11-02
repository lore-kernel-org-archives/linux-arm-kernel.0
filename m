From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 1 Nov 2017 23:40:31 -0700
Subject: [PATCH v3] clk: at91: utmi: set the mainck rate
In-Reply-To: <20170906095159.13295-1-ludovic.desroches@microchip.com>
References: <20170906095159.13295-1-ludovic.desroches@microchip.com>
Message-ID: <20171102064031.GC30645@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06, Ludovic Desroches wrote:
> By default, it is assumed that the UTMI clock is generated from a 12 MHz
> reference clock (MAINCK). If it's not the case, the FREQ field of the
> SFR_UTMICKTRIM has to be updated to generate the UTMI clock in the
> proper way.
> 
> The UTMI clock has a fixed rate of 480 MHz. In fact, there is no
> multiplier we can configure. The multiplier is managed internally,
> depending on the reference clock frequency, to achieve the target of
> 480 MHz.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
