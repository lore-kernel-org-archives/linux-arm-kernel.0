From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 6 May 2016 15:30:02 -0700
Subject: [PATCH v4 01/11] clk: sunxi: Add display and TCON0 clocks driver
In-Reply-To: <1461590572-4027-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1461590572-4027-1-git-send-email-maxime.ripard@free-electrons.com>
 <1461590572-4027-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160506223002.GE3492@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25, Maxime Ripard wrote:
> The A10 SoCs and its relatives has a special clock controller to drive the
> display engines (both frontend and backend), that have a lot in common with
> the clock to drive the first TCON channel.
> 
> Add a driver to support both.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

Unless I can merge this into clk-next? Wasn't clear to me.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
