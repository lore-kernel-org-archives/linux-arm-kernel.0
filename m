From: will.deacon@arm.com (Will Deacon)
Date: Mon, 5 Dec 2016 11:24:21 +0000
Subject: [PATCH 1/1] arm64: Correcting format specifier for printing 64
 bit addresses
In-Reply-To: <1480925393-8386-1-git-send-email-maninder1.s@samsung.com>
References: <1480925393-8386-1-git-send-email-maninder1.s@samsung.com>
Message-ID: <20161205112421.GB14058@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 05, 2016 at 01:39:53PM +0530, Maninder Singh wrote:
> This patch corrects format specifier for printing 64 bit addresses.
> 
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> ---
>  arch/arm64/kernel/signal.c |  2 +-
>  arch/arm64/kvm/sys_regs.c  |  8 ++++++--
>  arch/arm64/mm/fault.c      | 15 ++++++++++-----
>  arch/arm64/mm/mmu.c        |  4 ++--
>  4 files changed, 19 insertions(+), 10 deletions(-)

Any reason not to fix kvm/trace.h too?

Anyway, rest of this looks fine:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
