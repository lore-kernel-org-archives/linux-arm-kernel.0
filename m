From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 6 Jul 2015 15:00:22 -0700
Subject: [PATCH 1/7] clk: rockchip: add support for phase inverters
In-Reply-To: <1436086820-3757-2-git-send-email-heiko@sntech.de>
References: <1436086820-3757-1-git-send-email-heiko@sntech.de>
 <1436086820-3757-2-git-send-email-heiko@sntech.de>
Message-ID: <20150706220021.GF20866@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05, Heiko Stuebner wrote:
> Most Rockchip socs have optional phase inverters connected to some
> clocks that move the clock-phase by 180 degrees.
> While not having any actual influence on the rate, the inverter
> provides its own simple recalc_rate callback as relying on the
> fallback in the framework is for "lazy developers" according
> to the documentation in the code.

The comment about lazy doesn't seem to apply anymore? So I've
dropped this last sentence.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
