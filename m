From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 20 Mar 2018 10:03:59 -0700
Subject: [PATCH v8 10/42] clk: davinci: New driver for davinci PSC clocks
In-Reply-To: <1521168778-27236-11-git-send-email-david@lechnology.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <1521168778-27236-11-git-send-email-david@lechnology.com>
Message-ID: <152156543978.183971.1705082607591158848@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting David Lechner (2018-03-15 19:52:26)
> This adds a new driver for mach-davinci PSC clocks. This is porting the
> code from arch/arm/mach-davinci/psc.c to the common clock framework and
> is converting it to use regmap to simplify the code. Additionally, it
> adds device tree support for these clocks.
> 
> Note: although there are similar clocks for TI Keystone we are not able
> to share the code for a few reasons. The keystone clocks are device tree
> only and use legacy one-node-per-clock bindings. Also the keystone
> driver makes the assumption that there is only one PSC per SoC and uses
> global variables, but here we have two controllers per SoC.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---

Applied to clk-next
