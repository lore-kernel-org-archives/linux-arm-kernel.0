From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 23 Dec 2014 11:57:29 +0000
Subject: [PATCH v5 06/19] arm/arm64: KVM: move kvm_register_device_ops()
 into vGIC probing
In-Reply-To: <1418042274-3246-7-git-send-email-andre.przywara@arm.com> (Andre
 Przywara's message of "Mon, 8 Dec 2014 12:37:41 +0000")
References: <1418042274-3246-1-git-send-email-andre.przywara@arm.com>
 <1418042274-3246-7-git-send-email-andre.przywara@arm.com>
Message-ID: <86lhly1suu.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 08 2014 at 12:37:41 PM, Andre Przywara <andre.przywara@arm.com> wrote:
> Currently we unconditionally register the GICv2 emulation device
> during the host's KVM initialization. Since with GICv3 support we
> may end up with only v2 or only v3 or both supported, we move the
> registration into the GIC probing function, where we will later know
> which combination is valid.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
