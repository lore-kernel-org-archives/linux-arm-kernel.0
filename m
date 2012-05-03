From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Thu, 3 May 2012 08:06:42 +0000
Subject: [PATCH-V6 3/3] ARM: OMAP: Make OMAP clocksource source
 selection using kernel param
In-Reply-To: <87mx5qfhb4.fsf@ti.com>
References: <1335967014-11937-1-git-send-email-hvaibhav@ti.com>
 <1335967014-11937-4-git-send-email-hvaibhav@ti.com> <87mx5qfhb4.fsf@ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EA12328@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2012 at 02:09:59, Hilman, Kevin wrote:
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > Cc: Ming Lei <tom.leiming@gmail.com>
> 
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> Tested-by: Kevin Hilman <khilman@ti.com>
> 
> tested on OMAP3530/Overo with default 32k timer and cmdline override for
> GPtimer.
> 

Thanks Kevin, I have submitted V7 version of this series with your ack and 
tested-by.

Tony,
Can you queue it for v3.5?

Thanks,
Vaibhav
