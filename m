From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Jun 2018 16:50:11 +0100
Subject: [PATCHv3 17/19] arm64: use SYSCALL_DEFINE6() for mmap
In-Reply-To: <20180618120310.39527-18-mark.rutland@arm.com>
References: <20180618120310.39527-1-mark.rutland@arm.com>
 <20180618120310.39527-18-mark.rutland@arm.com>
Message-ID: <20180619155011.7w24tzx2hqsv53sj@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 01:03:08PM +0100, Mark Rutland wrote:
> We don't currently annotate our mmap implementation as a syscall, as we
> need to do to use pt_regs syscall wrappers.
> 
> Let's mark it as a real syscall.
> 
> There should be no functional change as a result of this patch.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
