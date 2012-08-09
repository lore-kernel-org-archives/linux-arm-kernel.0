From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 9 Aug 2012 16:18:35 +0800
Subject: imx6q restart is broken
In-Reply-To: <20120809080648.GB14102@arm.com>
References: <20120808101817.GA14718@S2101-09.ap.freescale.net>
 <50224547.9020000@de.bosch.com> <50232C17.9000700@gmail.com>
 <20120809044131.GF14718@S2101-09.ap.freescale.net>
 <20120809080648.GB14102@arm.com>
Message-ID: <20120809081833.GA15492@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 09, 2012 at 09:06:48AM +0100, Catalin Marinas wrote:
> Does this work if you always define cpu_relax() to smp_mb() (even on
> ARMv7) and compile the kernel to v7-only? In this case, the smp_mb()
> would use the DMB instruction rather than the CP15 equivalent. It's not
> a solution, just trying to understand the problem better.
> 
This is a test I already did a couple of hours ago.  No, it does not
work.  The kernel hangs at the same place.

-- 
Regards,
Shawn
