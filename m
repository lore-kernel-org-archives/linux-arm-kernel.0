From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 14 Mar 2015 15:44:03 +0100
Subject: [PATCH 07/12] KVM: arm/arm64: simplify vgic_find_range() and
 callers
In-Reply-To: <1426263012-22935-8-git-send-email-andre.przywara@arm.com>
References: <1426263012-22935-1-git-send-email-andre.przywara@arm.com>
 <1426263012-22935-8-git-send-email-andre.przywara@arm.com>
Message-ID: <20150314144403.GM10935@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 13, 2015 at 04:10:07PM +0000, Andre Przywara wrote:
> The vgic_find_range() function in vgic.c takes a struct kvm_exit_mmio
> argument, but actually only used the length field in there. Since we
> need to get rid of that structure in that part of the code anyway,
> let's rework the function (and it's callers) to pass the length
> argument to the function directly.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
