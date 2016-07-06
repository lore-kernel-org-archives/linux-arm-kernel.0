From: geoff@infradead.org (Geoff Levand)
Date: Wed, 06 Jul 2016 10:48:59 -0700
Subject: [PATCH v21 2/8] arm64: limit memory regions based on DT
 property, usable-memory
In-Reply-To: <20160706075226.27609-3-takahiro.akashi@linaro.org>
References: <20160706075226.27609-1-takahiro.akashi@linaro.org>
 <20160706075226.27609-3-takahiro.akashi@linaro.org>
Message-ID: <1467827339.8880.45.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-07-06 at 16:52 +0900, AKASHI Takahiro wrote:
> Crash dump kernel will be run with a limited range of memory as System
> RAM.
> 
> On arm64, we will use a device-tree property under /chosen,
>    linux,usable-memory = 
> in order for primary kernel either on uefi or non-uefi (device tree only)
> system to hand over the information about usable memory region to crash
> dump kernel. This property will supercede entries in uefi memory map table
> and "memory" nodes in a device tree.
> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

This all looks OK.

Reviewed-by: Geoff Levand <geoff@infradead.org>
