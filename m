From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 20 Sep 2016 17:04:24 -0700
Subject: [PATCH v3 3/5] clk: at91: sckc: optimize boot time
In-Reply-To: <20160920205833.19638-4-alexandre.belloni@free-electrons.com>
References: <20160920205833.19638-1-alexandre.belloni@free-electrons.com>
 <20160920205833.19638-4-alexandre.belloni@free-electrons.com>
Message-ID: <20160921000424.GJ8319@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20, Alexandre Belloni wrote:
> Assume that if the oscillator is enabled (OSC32EN bit is present), the
> delay has already elapsed as the bootloader probably waited for the
> oscillator to settle. This could waste up to 1.2s.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
