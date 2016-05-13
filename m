From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 13 May 2016 12:11:47 +0200
Subject: [PATCH v3 38/55] KVM: arm/arm64: vgic-new: vgic_kvm_device: KVM
 device ops registration
In-Reply-To: <1462531568-9799-39-git-send-email-andre.przywara@arm.com>
References: <1462531568-9799-1-git-send-email-andre.przywara@arm.com>
 <1462531568-9799-39-git-send-email-andre.przywara@arm.com>
Message-ID: <20160513101147.GA16274@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 06, 2016 at 11:45:51AM +0100, Andre Przywara wrote:
> From: Eric Auger <eric.auger@linaro.org>
> 
> This patch introduces the skeleton for the KVM device operations
> associated to KVM_DEV_TYPE_ARM_VGIC_V2 and KVM_DEV_TYPE_ARM_VGIC_V3.
> 
> At that stage kvm_vgic_create is stubbed.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
