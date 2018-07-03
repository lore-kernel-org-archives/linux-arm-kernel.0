From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 3 Jul 2018 16:09:44 +0100
Subject: [PATCH 0/2] Allwinner A64 timer workaround
In-Reply-To: <20180511022751.9096-1-samuel@sholland.org>
References: <20180511022751.9096-1-samuel@sholland.org>
Message-ID: <2c16d5ab-38f7-8f3e-875c-19e8032f440a@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/18 03:27, Samuel Holland wrote:
> Hello,
> 
> Several people (including me) have experienced extremely large system
> clock jumps on their A64-based devices, apparently due to the
> architectural timer going backward, which is interpreted by Linux as
> the timer wrapping around after 2^56 cycles.
> 
> Investigation led to discovery of some obvious problems with this SoC's
> architectural timer, and this patch series introduces what I believe is
> the simplest workaround. More details are in the commit message for
> patch 1. Patch 2 simply enables the workaround in the device tree.

What's the deal with this series? There was a couple of nits to address,
and I was more or less expecting a v2.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
