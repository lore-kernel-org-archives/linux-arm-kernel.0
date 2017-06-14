From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 14 Jun 2017 09:05:34 -0700
Subject: [PATCHv5 2/2] clk: keystone: Add sci-clk driver support
In-Reply-To: <1497337767-10218-1-git-send-email-t-kristo@ti.com>
References: <1497337767-10218-1-git-send-email-t-kristo@ti.com>
Message-ID: <20170614160534.GZ20170@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13, Tero Kristo wrote:
> In K2G, the clock handling is done through firmware executing on a
> separate core. Linux kernel needs to communicate to the firmware
> through TI system control interface to access any power management
> related resources, including clocks.
> 
> The keystone sci-clk driver does this, by communicating to the
> firmware through the TI SCI driver. The driver adds support for
> registering clocks through DT, and basic required clock operations
> like prepare/get_rate, etc.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---

Applied to clk-next + made ti_sci_init_clocks() static

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
