From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 20 Mar 2018 10:03:36 -0700
Subject: [PATCH v8 02/42] clk: davinci: New driver for davinci PLL clocks
In-Reply-To: <1521168778-27236-3-git-send-email-david@lechnology.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <1521168778-27236-3-git-send-email-david@lechnology.com>
Message-ID: <152156541626.183971.14116213325024297115@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting David Lechner (2018-03-15 19:52:18)
> This adds a new driver for mach-davinci PLL clocks. This is porting the
> code from arch/arm/mach-davinci/clock.c to the common clock framework.
> Additionally, it adds device tree support for these clocks.
> 
> The ifeq ($(CONFIG_COMMON_CLK), y) in the Makefile is needed to prevent
> compile errors until the clock code in arch/arm/mach-davinci is removed.
> 
> Note: although there are similar clocks for TI Keystone we are not able
> to share the code for a few reasons. The keystone clocks are device tree
> only and use legacy one-node-per-clock bindings. Also the register
> layouts are a bit different, which would add even more if/else mess
> to the keystone clocks. And the keystone PLL driver doesn't support
> setting clock rates.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---

Applied to clk-next
