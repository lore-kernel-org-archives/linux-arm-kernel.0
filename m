From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 15 Apr 2016 15:39:36 -0700
Subject: [PATCH v3 04/19] clk: sunxi: Add TCON channel1 clock
In-Reply-To: <1458751122-23976-5-git-send-email-maxime.ripard@free-electrons.com>
References: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
 <1458751122-23976-5-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160415223936.GU14441@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/23, Maxime Ripard wrote:
> The TCON is a controller generating the timings to output videos signals,
> acting like both a CRTC and an encoder.
> 
> It has two channels depending on the output, each channel being driven by
> its own clock (and own clock controller).
> 
> Add a driver for the channel 1 clock.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
