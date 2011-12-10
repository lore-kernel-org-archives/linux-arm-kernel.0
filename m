From: will.deacon@arm.com (Will Deacon)
Date: Sat, 10 Dec 2011 13:24:06 +0000
Subject: [PATCH 4/4] Use generic ARM instruction set condition code
 checks for kprobes.
In-Reply-To: <20111209185503.19655.37484.stgit@localhost6.localdomain6>
References: <20111209185302.19655.36481.stgit@localhost6.localdomain6>
 <20111209185503.19655.37484.stgit@localhost6.localdomain6>
Message-ID: <20111210132406.GE8292@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2011 at 06:55:44PM +0000, Leif Lindholm wrote:
> This patch changes the kprobes implementation to use the generic ARM
> instruction set condition code checks, rather than a dedicated
> implementation.
> 
> Signed-off-by: Leif Lindholm <leif.lindholm@arm.com>
> ---
> Tixy's ACK removed as patch modified.
> 
>  arch/arm/kernel/kprobes-test.c |   66 ++++------------------------------------
>  1 files changed, 7 insertions(+), 59 deletions(-)
> 

This looks good to me. Given that Tixy's re-acked it, my reviewed-by is fairly
worthless, but here it is anyway (take it or leave it!):

Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
