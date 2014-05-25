From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 25 May 2014 16:35:08 +0100
Subject: [PATCH v2 5/9] arm64: KVM: use separate tables for AArch32 32
 and 64bit traps
In-Reply-To: <1400604945-25247-6-git-send-email-marc.zyngier@arm.com>
References: <1400604945-25247-1-git-send-email-marc.zyngier@arm.com>
 <1400604945-25247-6-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140525153508.GF3866@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 05:55:41PM +0100, Marc Zyngier wrote:
> An interesting "feature" of the CP14 encoding is that there is
> an overlap between 32 and 64bit registers, meaning they cannot
> live in the same table as we did for CP15.
> 
> Create separate tables for 64bit CP14 and CP15 registers, and
> let the top level handler use the right one.
> 
> Reviewed-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
