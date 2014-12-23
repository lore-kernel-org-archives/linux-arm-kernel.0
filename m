From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 23 Dec 2014 11:58:56 +0000
Subject: [PATCH v5 07/19] arm/arm64: KVM: dont rely on a valid GICH base
 address
In-Reply-To: <1418042274-3246-8-git-send-email-andre.przywara@arm.com> (Andre
 Przywara's message of "Mon, 8 Dec 2014 12:37:42 +0000")
References: <1418042274-3246-1-git-send-email-andre.przywara@arm.com>
 <1418042274-3246-8-git-send-email-andre.przywara@arm.com>
Message-ID: <86h9wm1ssf.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 08 2014 at 12:37:42 PM, Andre Przywara <andre.przywara@arm.com> wrote:
> To check whether the vGIC was already initialized, we currently check
> the GICH base address for not being NULL. Since with GICv3 we may
> get along without this address, lets use the irqchip_in_kernel()
> function to detect an already initialized vGIC.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
