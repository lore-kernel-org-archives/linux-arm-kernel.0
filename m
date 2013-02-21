From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 21 Feb 2013 15:29:03 +0800
Subject: i.MX6 Solo: maxcpus=1 vs. nosmp: Warning from smp_twd.c?
In-Reply-To: <5125C9B1.8050209@de.bosch.com>
References: <511CF063.3010200@de.bosch.com>
 <20130214143752.GH17833@n2100.arm.linux.org.uk>
 <20130218025021.GI6782@S2101-09.ap.freescale.net>
 <5125C9B1.8050209@de.bosch.com>
Message-ID: <20130221072900.GA23442@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 21, 2013 at 08:16:01AM +0100, Dirk Behme wrote:
> >diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
> >index c092115..f796b83 100644
> >--- a/arch/arm/kernel/smp_twd.c
> >+++ b/arch/arm/kernel/smp_twd.c
> >@@ -392,6 +392,6 @@ void __init twd_local_timer_of_register(void)
> >        err = twd_local_timer_common_register(np);
> >
> > out:
> >-       WARN(err, "twd_local_timer_of_register failed (%d)\n", err);
> >+       pr_warn("twd_local_timer_of_register failed (%d)\n", err);
> > }
> > #endif
> 
> Any news on this? Time to move it to the patch system?
> 
Thanks for reminding.  I will send it out today.

Shawn
