From: nm@ti.com (Nishanth Menon)
Date: Wed, 7 Nov 2018 15:00:59 -0600
Subject: [PATCH] arm64: dts: k3-am65-wakeup: Fix wakeup_uart reg address
In-Reply-To: <8dc7a5d5-3e21-c2be-fde1-3f2bc6396bec@ti.com>
References: <20180927050146.17847-1-vigneshr@ti.com>
 <8dc7a5d5-3e21-c2be-fde1-3f2bc6396bec@ti.com>
Message-ID: <20181107210059.j2wd4v2uawsjniol@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:10-20181005, Vutla, Lokesh wrote:
> 
> 
> On Thursday 27 September 2018 10:31 AM, Vignesh R wrote:
> > cbass_wakeup interconnect which is the parent of wakeup_uart node
> > defines address-cells=1 and size-cells=1, therefore fix up reg property
> > of wakeup_uart node accordingly. Otherwise, this UART instance fails to
> > probe if enabled.
> > 
> > Fixes: 4201af2544b3 ("arm64: dts: ti: am654: Add uart nodes")
> > Signed-off-by: Vignesh R <vigneshr@ti.com>
> 
> Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Tero:

Could we pick this up for rc2? looks like $subject might be good to fix
up to:
arm64: dts: ti: k3-am65-wakeup: Fix wakeup_uart reg address
instead of
arm64: dts: k3-am65-wakeup: Fix wakeup_uart reg address

could be fixed locally.

-- 
Regards,
Nishanth Menon
