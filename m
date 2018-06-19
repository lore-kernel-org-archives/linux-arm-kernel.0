From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 19 Jun 2018 16:46:10 +0100
Subject: [PATCHv3 15/19] arm64: remove in-kernel call to sys_personality()
In-Reply-To: <20180618120310.39527-16-mark.rutland@arm.com>
References: <20180618120310.39527-1-mark.rutland@arm.com>
 <20180618120310.39527-16-mark.rutland@arm.com>
Message-ID: <20180619154610.v5nqo7ai3y5rr635@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2018 at 01:03:06PM +0100, Mark Rutland wrote:
> With pt_regs syscall wrappers, the calling convention for
> sys_personality() will change. Use ksys_personality(), which is
> functionally equivalent.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
