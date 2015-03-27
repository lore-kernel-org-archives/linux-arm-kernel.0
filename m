From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 27 Mar 2015 17:00:54 +0100
Subject: [PATCH v3 07/11] KVM: arm/arm64: implement kvm_io_bus MMIO
 handling for the VGIC
In-Reply-To: <1427380778-942-8-git-send-email-andre.przywara@arm.com>
References: <1427380778-942-1-git-send-email-andre.przywara@arm.com>
 <1427380778-942-8-git-send-email-andre.przywara@arm.com>
Message-ID: <20150327160054.GC5121@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 02:39:34PM +0000, Andre Przywara wrote:
> Currently we use a lot of VGIC specific code to do the MMIO
> dispatching.
> Use the previous reworks to add kvm_io_bus style MMIO handlers.
> 
> Those are not yet called by the MMIO abort handler, also the actual
> VGIC emulator function do not make use of it yet, but will be enabled
> with the following patches.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
