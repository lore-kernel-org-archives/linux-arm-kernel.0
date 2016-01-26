From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 26 Jan 2016 17:45:04 +0000
Subject: [PATCH v4 05/22] arm64: kvm: deal with kernel symbols outside of
 linear mapping
In-Reply-To: <1453828249-14467-6-git-send-email-ard.biesheuvel@linaro.org>
References: <1453828249-14467-1-git-send-email-ard.biesheuvel@linaro.org>
 <1453828249-14467-6-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <56A7B0A0.3020003@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/01/16 17:10, Ard Biesheuvel wrote:
> KVM on arm64 uses a fixed offset between the linear mapping at EL1 and
> the HYP mapping at EL2. Before we can move the kernel virtual mapping
> out of the linear mapping, we have to make sure that references to kernel
> symbols that are accessed via the HYP mapping are translated to their
> linear equivalent.
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
