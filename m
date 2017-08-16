From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 16 Aug 2017 16:39:49 +0100
Subject: [PATCHv2 0/3] arm64 xilinx zynqmp firmware interface
In-Reply-To: <cover.1502886277.git.michal.simek@xilinx.com>
References: <cover.1502886277.git.michal.simek@xilinx.com>
Message-ID: <43deeed7-32c8-7914-5f44-862ebbe14a3b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/08/17 13:24, Michal Simek wrote:
> Hi,
> 
> xilinx is using this interface for very long time and we can't merge our
> driver changes to Linux because of missing communication layer with
> firmware. This interface was developed before scpi and scmi was
> available. In connection to power management scpi and scmi are missing
> pieces which we already use. There is a separate discussion how to
> extend scmi to support all our use cases.

So maybe we should wait and see where this discussion is going before we
merge yet another firmware interface?

> This simply patch is not adding any power management features but only
> adding minimum functionality which are needed for drivers.

I don't get it. 600 lines of firmware interface that isn't used by
anything? Or is it? Needed by which driver?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
