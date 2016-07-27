From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 27 Jul 2016 07:33:31 +0100
Subject: [PATCH v6] KVM: arm/arm64: Add VGICv3 save/restore API
 documentation
In-Reply-To: <20160726112103.27799-1-christoffer.dall@linaro.org>
References: <20160726112103.27799-1-christoffer.dall@linaro.org>
Message-ID: <20160727073331.4d0e1018@why.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Jul 2016 13:21:03 +0200
Christoffer Dall <christoffer.dall@linaro.org> wrote:

> Factor out the GICv3 and ITS-specific documentation into a separate
> documentation file.  Add description for how to access distributor,
> redistributor, and CPU interface registers for GICv3 in this new file,
> and add a group for accessing level triggered IRQ information for GICv3
> as well.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Without deviation from the norm, progress is not possible.
