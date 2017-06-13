From: will.deacon@arm.com (Will Deacon)
Date: Tue, 13 Jun 2017 09:50:29 +0100
Subject: [PATCH] Export save_stack_trace_tsk for ARM and ARM64
In-Reply-To: <20170612222431.1854-1-dustinb@codeaurora.org>
References: <20170612222431.1854-1-dustinb@codeaurora.org>
Message-ID: <20170613085029.GA5374@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 12, 2017 at 03:24:31PM -0700, Dustin Brown wrote:
> To help in debugging driver modules on ARM platforms, export
> save_stack_trace_tsk() for ARM and ARM64 architectures.
> ---
>  arch/arm/kernel/stacktrace.c   | 1 +
>  arch/arm64/kernel/stacktrace.c | 1 +
>  2 files changed, 2 insertions(+)

If you split this into two patches, I can pick up the arm64 one.

Will
