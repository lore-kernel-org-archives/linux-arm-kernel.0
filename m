From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 30 Oct 2015 14:37:34 -0700
Subject: [PATCH 04/19] clk: sunxi: Add TCON channel1 clock
In-Reply-To: <1446214865-3972-5-git-send-email-maxime.ripard@free-electrons.com>
References: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
 <1446214865-3972-5-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20151030213734.GI19782@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30, Maxime Ripard wrote:
> The TCON is a controller generating the timings to output videos signals,
> acting like both a CRTC and an encoder.
> 
> It has two channels depending on the output, each channel being driven by
> its own clock (and own clock controller).
> 
> Add a driver for the channel 1 clock.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Similar comments apply to patches 3 and 4. Was the same code
copy/pasted two more times and then changed to have different
values? Looks like we should consolidate all that stuff into
something more generic so that we don't have the same problems 3
times.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
