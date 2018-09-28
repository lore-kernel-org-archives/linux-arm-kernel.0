From: nm@ti.com (Nishanth Menon)
Date: Fri, 28 Sep 2018 17:48:41 -0500
Subject: Bad MAINTAINERS pattern in section 'Texas Instruments' System
 Control Interface (TISCI) Protocol Driver'
In-Reply-To: <20180928220455.31806-1-joe@perches.com>
References: <20180928220455.31806-1-joe@perches.com>
Message-ID: <20180928224841.pbupoemlo4i2j3ks@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22:04-20180928, Joe Perches wrote:
> Please fix this defect appropriately.
> 
> linux-next MAINTAINERS section:
> 
> 	14531	Texas Instruments' System Control Interface (TISCI) Protocol Driver
> 	14532	M:	Nishanth Menon <nm@ti.com>
> 	14533	M:	Tero Kristo <t-kristo@ti.com>
> 	14534	M:	Santosh Shilimkar <ssantosh@kernel.org>
> 	14535	L:	linux-arm-kernel at lists.infradead.org
> 	14536	S:	Maintained
> 	14537	F:	Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
> 	14538	F:	drivers/firmware/ti_sci*
> 	14539	F:	include/linux/soc/ti/ti_sci_protocol.h
> 	14540	F:	Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
> -->	14541	F:	include/dt-bindings/genpd/k2g.h
> 	14542	F:	drivers/soc/ti/ti_sci_pm_domains.c
> 	14543	F:	Documentation/devicetree/bindings/reset/ti,sci-reset.txt
> 	14544	F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
> 	14545	F:	drivers/clk/keystone/sci-clk.c
> 	14546	F:	drivers/reset/reset-ti-sci.c

Sorry about that Joe. Thanks for the headsup.

https://patchwork.kernel.org/patch/10620509/ posted.
-- 
Regards,
Nishanth Menon
