From: t-kristo@ti.com (Tero Kristo)
Date: Mon, 19 May 2014 17:21:43 +0300
Subject: [PATCHv2 00/14]: ARM: OMAP2: clock DT conversion
In-Reply-To: <1393924700-6510-1-git-send-email-t-kristo@ti.com>
References: <1393924700-6510-1-git-send-email-t-kristo@ti.com>
Message-ID: <537A1377.7070004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2014 11:18 AM, Tero Kristo wrote:
> Hi,
>
> Changes compared to v1:
> - fixed OMAP2 only build issues
> - fixed OMAP2420 boot issues
> - added patch #13 and #14 to remove legacy clock data for OMAP2/OMAP3
> - fixed smatch + DT bindings documentation problems reported by Nishanth
>
> This set is un-tested on OMAP2 hardware as I don't have access to any. So,
> any testing feedback welcome.
>
> Test branch available:
> tree: https://github.com/t-kristo/linux-pm.git
> branch: 3.14-rc4-omap2-dt-clks-v2

I just queued these for 3.16/ti-clk-drv.

-Tero

>
> -Tero
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
