From: richardcochran@gmail.com (Richard Cochran)
Date: Mon, 28 Apr 2014 18:18:56 +0200
Subject: [PATCH 5/6] ARM: AM43xx: clk: Change the cpts ref clock source
 to dpll_core_m5 clk
In-Reply-To: <535E4FDC.70306@ti.com>
References: <1398658225-25873-1-git-send-email-george.cherian@ti.com>
 <1398658225-25873-6-git-send-email-george.cherian@ti.com>
 <20140428071034.GB4380@netboy> <535E4FDC.70306@ti.com>
Message-ID: <20140428161856.GB4266@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 06:25:56PM +0530, George Cherian wrote:
> In beagle bone white (AM335x)  CPTS has a choice of 2 clocksource
> -dpll_core_m5_ck
> -dpll_core_m4_ck
> and by default  dpll_core_m5_ck is used. Where as in AM437x the
> default clocksource used is dpll_core_m4_ck .

Is your patch changing the default clock for am335x?

If yes, it shouldn't.
If no, then the patch description should say so.

Thanks,
Richard

 
