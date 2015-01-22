From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 22 Jan 2015 14:48:47 -0800
Subject: [PATCH v12 4/6] clk: Add rate constraints to clocks
In-Reply-To: <1421943207-5180-5-git-send-email-tomeu.vizoso@collabora.com>
References: <1421943207-5180-1-git-send-email-tomeu.vizoso@collabora.com>
 <1421943207-5180-5-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150122224847.GQ27202@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22, Tomeu Vizoso wrote:
> Adds a way for clock consumers to set maximum and minimum rates. This
> can be used for thermal drivers to set minimum rates, or by misc.
> drivers to set maximum rates to assure a minimum performance level.
> 
> Changes the signature of the determine_rate callback by adding the
> parameters min_rate and max_rate.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> 

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
