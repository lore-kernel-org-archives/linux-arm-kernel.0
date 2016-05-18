From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 18 May 2016 16:15:51 +0200
Subject: [PATCH v4 30/56] KVM: arm/arm64: vgic-new: Add TARGET registers
 handlers
In-Reply-To: <1463392481-26583-31-git-send-email-andre.przywara@arm.com>
References: <1463392481-26583-1-git-send-email-andre.przywara@arm.com>
 <1463392481-26583-31-git-send-email-andre.przywara@arm.com>
Message-ID: <20160518141551.GF6666@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2016 at 10:53:18AM +0100, Andre Przywara wrote:
> The target register handlers are v2 emulation specific, so their
> implementation lives entirely in vgic-mmio-v2.c.
> We copy the old VGIC behaviour of assigning an IRQ to the first VCPU
> set in the target mask instead of making it possibly pending on
> multiple VCPUs.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
