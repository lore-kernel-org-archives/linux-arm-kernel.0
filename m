From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 10 May 2018 21:00:02 +0530
Subject: [PATCH v3 2/2] clk: davinci: pll-dm355: fix SYSCLKn parent names
In-Reply-To: <20180509153642.22399-3-david@lechnology.com>
References: <20180509153642.22399-1-david@lechnology.com>
 <20180509153642.22399-3-david@lechnology.com>
Message-ID: <05fe08f6-5860-6734-2982-01a2afd63980@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 May 2018 09:06 PM, David Lechner wrote:
> This fixes the parent clock names of the SYSCLKn clocks for the DM355
> SoC in the TI DaVinici PLL clock driver.
> 
> It appears that this name just didn't get updated to the correct name
> like the other SoCs during the driver's development.
> 
> Reported-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: David Lechner <david@lechnology.com>

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
