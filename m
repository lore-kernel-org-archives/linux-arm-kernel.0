From: will.deacon@arm.com (Will Deacon)
Date: Tue, 5 Jun 2018 16:37:07 +0100
Subject: [RFC PATCH -tip v5 17/27] arm64: kprobes: Don't call the
 ->break_handler() in arm kprobes code
In-Reply-To: <152812780433.10068.4191004481518140821.stgit@devbox>
References: <152812730943.10068.5166429445118734697.stgit@devbox>
 <152812780433.10068.4191004481518140821.stgit@devbox>
Message-ID: <20180605153706.GB26352@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2018 at 12:56:44AM +0900, Masami Hiramatsu wrote:
> Don't call the ->break_handler() from the arm kprobes code,
> because it was only used by jprobes which got removed.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm64/kernel/probes/kprobes.c |    8 --------
>  1 file changed, 8 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
