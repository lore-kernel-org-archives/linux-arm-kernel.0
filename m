From: will.deacon@arm.com (Will Deacon)
Date: Sat, 10 Dec 2011 13:21:24 +0000
Subject: [PATCH 2/4] Use generic ARM instruction set condition code
 checks for nwfpe.
In-Reply-To: <20111209185434.19655.59201.stgit@localhost6.localdomain6>
References: <20111209185302.19655.36481.stgit@localhost6.localdomain6>
 <20111209185434.19655.59201.stgit@localhost6.localdomain6>
Message-ID: <20111210132124.GC8292@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2011 at 06:54:40PM +0000, Leif Lindholm wrote:
> This patch changes the nwfpe implementation to use the new generic
> ARM instruction set condition code checks, rather than a local
> implementation. It also removes the existing condition code checking,
> which has been used for the generic support (in kernel/opcodes.{ch}).
> 
> This code has not been tested beyond building, linking and booting.
> 
> Signed-off-by: Leif Lindholm <leif.lindholm@arm.com>
> ---
>  arch/arm/nwfpe/entry.S    |    8 +++++---
>  arch/arm/nwfpe/fpopcode.c |   26 --------------------------
>  arch/arm/nwfpe/fpopcode.h |    3 ---
>  3 files changed, 5 insertions(+), 32 deletions(-)

Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
