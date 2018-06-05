From: will.deacon@arm.com (Will Deacon)
Date: Tue, 5 Jun 2018 16:34:21 +0100
Subject: [RFC PATCH -tip v5 06/27] arm64: kprobes: Remove jprobe
 implementation
In-Reply-To: <152812748464.10068.10380156315388629319.stgit@devbox>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
 <152812748464.10068.10380156315388629319.stgit@devbox>
Message-ID: <20180605153420.GA26352@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2018 at 12:51:24AM +0900, Masami Hiramatsu wrote:
> Remove arch dependent setjump/longjump functions
> and unused fields in kprobe_ctlblk for jprobes
> from arch/arm64.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm64/include/asm/kprobes.h   |    1 -
>  arch/arm64/kernel/probes/kprobes.c |   68 ------------------------------------
>  2 files changed, 69 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
