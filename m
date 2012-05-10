From: r.sricharan@ti.com (Sricharan R)
Date: Thu, 10 May 2012 22:47:38 +0530
Subject: [PATCH 0/4] ARM: OMAP2+: Misc cleanup part2
In-Reply-To: <1336669615-16454-1-git-send-email-r.sricharan@ti.com>
References: <1336669615-16454-1-git-send-email-r.sricharan@ti.com>
Message-ID: <e9a14034778ef9c8047887de64b5dbae@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: R Sricharan [mailto:r.sricharan at ti.com]
> Sent: Thursday, May 10, 2012 10:37 PM
> To: linux-omap at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org; santosh.shilimkar at ti.com;
> tony at atomide.com; b-cousson at ti.com; r.sricharan at ti.com; paul at pswan.com
> Subject: [PATCH 0/4] ARM: OMAP2+: Misc cleanup part2
>
> This is a continuation of the previous cleanup series from
> santosh.shilimkar at ti.com [1]. Patches are outcome of the OMAP5
> review suggestions from Tony/Benoit/Santosh/Rajendra.
>
> [1]  http://www.spinics.net/lists/linux-omap/msg69730.html
>
> R Sricharan (4):
>   ARM: OMAP2+: Introduce CONFIG_SOC_HAS_OMAP_DPLL macro
>   ARM: OMAP2+: Move the stubbed prm and cm functions to prcm.c file and
>     make them __weak.
>   ARM: OMAP2+: Move stubbed secure_sram_reserve function to a common.c
>     and call it __weak
>   ARM: OMAP: counter-32k: Select the CR register offset using the IP
>     scheme.
>
 Forgot to add the below reviewed-by tag.
   Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Thanks,
 Sricharan
