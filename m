From: kevin.wells@nxp.com (Kevin Wells)
Date: Tue, 2 Mar 2010 18:19:20 +0100
Subject: LPC32XX architecture files (updated v5)
In-Reply-To: <1267228430-27193-1-git-send-email-wellsk40@gmail.com>
References: <1267228430-27193-1-git-send-email-wellsk40@gmail.com>
Message-ID: <083DF309106F364B939360100EC290F805CCF9315D@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Russell,

Can I submit these patches to the patch tracker? Or is there
another way to get them accepted? I'm sure we'll continue
finding small issues here and there over time, but we are
committed to maintaining and improving them in the long run.
(And I would like to start getting the other drivers outside
of the ARM area going).

thanks,
Kevin

> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-
> kernel-bounces at lists.infradead.org] On Behalf Of wellsk40 at gmail.com
> Sent: Friday, February 26, 2010 3:54 PM
> To: linux-arm-kernel at lists.infradead.org
> Subject: LPC32XX architecture files (updated v5)
> 
> 
> Thanks for reviewing. This is the 5th patchset. Updates
> are listed below..
> 
> Greatly simplified debug-macro.S (similar to other drivers
> 	that use debug-8250.S)
> Clock driver changes - type fixes to some functions, clock
> 	tree enabled from top down and disabled from bottom
> 	up, fixed round clock support, AMBA driver fixes for
> 	get_clk_rate, AMBA fix to allow a clock rate to be
> 	set without the clock needing to be enabled, other
> 	review changes
> 
> thanks,
> Kevin Wells
> NXP Semiconductors
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
