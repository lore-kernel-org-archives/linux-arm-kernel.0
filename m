From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 10 May 2018 20:59:33 +0530
Subject: [PATCH v3 1/2] clk: davinci: pll-dm355: drop pll2_sysclk2
In-Reply-To: <20180509153642.22399-2-david@lechnology.com>
References: <20180509153642.22399-1-david@lechnology.com>
 <20180509153642.22399-2-david@lechnology.com>
Message-ID: <e1f89e7c-d07b-990d-fede-65d7d02c3e3a@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 May 2018 09:06 PM, David Lechner wrote:
> This removes pll2_sysclk2 from the TI DM355 clock driver. This SoC
> doesn't have such a clock. Also, SYSCLK_ALWAYS_ENABLED is transferred
> to pll2_sysclk1 since it drives the DDR and doesn't have another
> mechanism to keep it on.
> 
> Reported-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: David Lechner <david@lechnology.com>

I would not have minded the SYSCLK_ALWAYS_ENABLED change to be a
separate patch too, but:

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
