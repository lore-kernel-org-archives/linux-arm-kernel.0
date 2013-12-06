From: will.deacon@arm.com (Will Deacon)
Date: Fri, 6 Dec 2013 16:31:37 +0000
Subject: [PATCH v2] ARM: add support for the Cortex-A12 processor
In-Reply-To: <1386342282-8769-1-git-send-email-jonathan.austin@arm.com>
References: <1386342282-8769-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <20131206163137.GC12376@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 06, 2013 at 03:04:42PM +0000, Jonathan Austin wrote:
> The A12 behaves as the A7/A15 does with respect to setting the SMP bit, and
> doesn't require TLB ops broadcasting to be explicitly enabled like the A9 does.
> 
> Note that as the ACTLR cannot (usually) be written from non-secure, it is the
> responsibility of the bootloader/firmware to set this bit per core - it is
> done here in Linux as last resort in case of bad firmware.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
> ---
> This V2 patch also adds A12 in asm/cputype.h, necessary for KVM, perf, among
> other things.

Ok, please put this in the patch system to supercede your eartlier version.

Will
