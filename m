From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 10 May 2016 16:18:31 +0200
Subject: [PATCH v3 20/55] KVM: arm/arm64: vgic-new: Implement
 kvm_vgic_vcpu_pending_irq
In-Reply-To: <1462531568-9799-21-git-send-email-andre.przywara@arm.com>
References: <1462531568-9799-1-git-send-email-andre.przywara@arm.com>
 <1462531568-9799-21-git-send-email-andre.przywara@arm.com>
Message-ID: <20160510141831.GH27623@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 06, 2016 at 11:45:33AM +0100, Andre Przywara wrote:
> From: Eric Auger <eric.auger@linaro.org>
> 
> Tell KVM whether a particular VCPU has an IRQ that needs handling
> in the guest. This is used to decide whether a VCPU is runnable.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
