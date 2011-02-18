From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Feb 2011 11:34:53 +0000
Subject: [PATCH 00/11] Rationalize and consolidate ARMs evaluation boards
In-Reply-To: <20110127134532.GE25968@n2100.arm.linux.org.uk>
References: <20110127134532.GE25968@n2100.arm.linux.org.uk>
Message-ID: <1298028893.11711.38.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2011-01-27 at 13:45 +0000, Russell King - ARM Linux wrote:
> This series, which applies on top of the CLCD series consolidates some
> of the code used on ARM platforms, in particular the FPGA interrupt,
> local timer, and SMP bring up code.
> 
> We also add sched_clock() support for Integrator/CP, but only when we're
> building only for Integrator/CP as Integrator/AP platforms don't have
> the 24MHz counter.  We also move the sched_clock() initialization to
> the early init callback, along with registering the clock lookups.
> 
> As we know how DMA is to be supported with primecells, we no longer need
> the DMA definitions which aren't used, so these are removed.

The whole series looks fine (acked. if you need one).

-- 
Catalin
