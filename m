From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 18 May 2016 16:02:24 +0200
Subject: [PATCH v4 48/56] KVM: arm/arm64: vgic-new: Add userland GIC CPU
 interface access
In-Reply-To: <1463392481-26583-49-git-send-email-andre.przywara@arm.com>
References: <1463392481-26583-1-git-send-email-andre.przywara@arm.com>
 <1463392481-26583-49-git-send-email-andre.przywara@arm.com>
Message-ID: <20160518140224.GQ3827@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2016 at 10:53:36AM +0100, Andre Przywara wrote:
> Using the VMCR accessors we provide access to GIC CPU interface state
> to userland by wiring it up to the existing userland interface.
> [Marc: move and make VMCR accessors static, streamline MMIO handlers]
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
