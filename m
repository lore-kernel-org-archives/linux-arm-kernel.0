From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 25 May 2014 16:34:39 +0100
Subject: [PATCH v2 2/9] arm64: move DBG_MDSCR_* to asm/debug-monitors.h
In-Reply-To: <1400604945-25247-3-git-send-email-marc.zyngier@arm.com>
References: <1400604945-25247-1-git-send-email-marc.zyngier@arm.com>
 <1400604945-25247-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140525153439.GC3866@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 05:55:38PM +0100, Marc Zyngier wrote:
> In order to be able to use the DBG_MDSCR_* macros from the KVM code,
> move the relevant definitions to the obvious include file.
> 
> Also move the debug_el enum to a portion of the file that is guarded
> by #ifndef __ASSEMBLY__ in order to use that file from assembly code.
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> Reviewed-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
