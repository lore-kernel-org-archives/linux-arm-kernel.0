From: will.deacon@arm.com (Will Deacon)
Date: Tue, 1 Aug 2017 15:31:26 +0100
Subject: [PATCH v2 0/2] arm64: Abstract syscallno manipulation
In-Reply-To: <1501595654-4014-1-git-send-email-Dave.Martin@arm.com>
References: <1501595654-4014-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170801143126.GB11534@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 01, 2017 at 02:54:12PM +0100, Dave Martin wrote:
> Changes since v1:
> 
>  * Change the argument of in_syscall() from int sycallno to a struct
>    pt_regs *, since that's more natural for the current callsites.
> 
>  * Add missing #include of <asm/ptrace.h>.
> 
>  * Minor commit message clarifications.

Please add my ack to these two now:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
