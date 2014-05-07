From: will.deacon@arm.com (Will Deacon)
Date: Wed, 7 May 2014 18:14:14 +0100
Subject: [PATCH 2/9] arm64: move DBG_MDSCR_* to asm/debug-monitors.h
In-Reply-To: <1399476054-21571-3-git-send-email-marc.zyngier@arm.com>
References: <1399476054-21571-1-git-send-email-marc.zyngier@arm.com>
 <1399476054-21571-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140507171414.GD3694@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 07, 2014 at 04:20:47PM +0100, Marc Zyngier wrote:
> In order to be able to use the DBG_MDSCR_* macros from the KVM code,
> move the relevant definitions to the obvious include file.
> 
> Also move the debug_el enum to a portion of the file that is guarded
> by #ifndef __ASSEMBLY__ in order to use that file from assembly code.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/debug-monitors.h | 19 ++++++++++++++-----
>  arch/arm64/kernel/debug-monitors.c      |  9 ---------
>  2 files changed, 14 insertions(+), 14 deletions(-)

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
