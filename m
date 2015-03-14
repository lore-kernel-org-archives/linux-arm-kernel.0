From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 14 Mar 2015 15:43:50 +0100
Subject: [PATCH 05/12] KVM: arm/arm64: rename struct kvm_mmio_range to
 vgic_io_range
In-Reply-To: <1426263012-22935-6-git-send-email-andre.przywara@arm.com>
References: <1426263012-22935-1-git-send-email-andre.przywara@arm.com>
 <1426263012-22935-6-git-send-email-andre.przywara@arm.com>
Message-ID: <20150314144350.GK10935@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 04:10:05PM +0000, Andre Przywara wrote:
> The name "kvm_mmio_range" is a bit bold, given that it only covers
> the VGIC's MMIO ranges. To avoid confusion with kvm_io_range, rename
> it to vgic_io_range.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
