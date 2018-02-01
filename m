From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 1 Feb 2018 15:25:07 +0530
Subject: [PATCH v6 10/41] clk: davinci: New driver for davinci PSC clocks
In-Reply-To: <1516468460-4908-11-git-send-email-david@lechnology.com>
References: <1516468460-4908-1-git-send-email-david@lechnology.com>
 <1516468460-4908-11-git-send-email-david@lechnology.com>
Message-ID: <8c0c10ec-c1ec-89b3-ae7b-2df61c22779a@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 20 January 2018 10:43 PM, David Lechner wrote:
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

Reviewed-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
