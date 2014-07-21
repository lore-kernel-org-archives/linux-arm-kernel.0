From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Jul 2014 11:36:43 +0100
Subject: [PATCH 3/4] ARM64: add IPI tracepoints
In-Reply-To: <1405660735-13408-4-git-send-email-nicolas.pitre@linaro.org>
References: <1405660735-13408-1-git-send-email-nicolas.pitre@linaro.org>
 <1405660735-13408-4-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20140721103643.GC12817@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 18, 2014 at 06:18:54AM +0100, Nicolas Pitre wrote:
> The strings used to list IPIs in /proc/interrupts are reused for tracing
> purposes.
> 
> While at it, the code is slightly cleaned up so the ipi_types array
> indices are no longer offset by IPI_RESCHEDULE whose value is 0 anyway.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
