From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Fri, 5 Oct 2018 20:40:22 +0530
Subject: [PATCH] arm64: dts: k3-am65-wakeup: Fix wakeup_uart reg address
In-Reply-To: <20180927050146.17847-1-vigneshr@ti.com>
References: <20180927050146.17847-1-vigneshr@ti.com>
Message-ID: <8dc7a5d5-3e21-c2be-fde1-3f2bc6396bec@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 27 September 2018 10:31 AM, Vignesh R wrote:
> cbass_wakeup interconnect which is the parent of wakeup_uart node
> defines address-cells=1 and size-cells=1, therefore fix up reg property
> of wakeup_uart node accordingly. Otherwise, this UART instance fails to
> probe if enabled.
> 
> Fixes: 4201af2544b3 ("arm64: dts: ti: am654: Add uart nodes")
> Signed-off-by: Vignesh R <vigneshr@ti.com>

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks and regards,
Lokesh
