From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 20 Sep 2016 17:04:20 -0700
Subject: [PATCH v3 2/5] clk: at91: Add sama5d4 sckc support
In-Reply-To: <20160920205833.19638-3-alexandre.belloni@free-electrons.com>
References: <20160920205833.19638-1-alexandre.belloni@free-electrons.com>
 <20160920205833.19638-3-alexandre.belloni@free-electrons.com>
Message-ID: <20160921000420.GI8319@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20, Alexandre Belloni wrote:
> Starting with sama5d4, the crystal oscillator is always enabled at startup
> and the SCKC doesn't have an OSC32EN bit anymore.
> 
> Add support for that new controller.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
