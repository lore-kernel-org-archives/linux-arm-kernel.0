From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 09 Jun 2015 18:09:53 +0100
Subject: [PATCH] KVM: arm/arm64: Enable the KVM-VFIO device
In-Reply-To: <1433517709-6872-1-git-send-email-eric.auger@linaro.org>
References: <1433517709-6872-1-git-send-email-eric.auger@linaro.org>
Message-ID: <55771DE1.7050405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/15 16:21, Eric Auger wrote:
> From: Kim Phillips <kim.phillips@linaro.org>
> 
> The KVM-VFIO device is used by the QEMU VFIO device. It is used to
> record the list of in-use VFIO groups so that KVM can manipulate
> them.
> 
> Signed-off-by: Kim Phillips <kim.phillips@linaro.org>
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> 
> ---
> 
> - previously included in KVM-VFIO IRQ forward control v6 series.
>   Rationale to put it aside is the unavailability of the kvm-vfio device
>   causes produces a warning when launching the QEMU VFIO platform device
>   that can puzzle some users (although not blocking):
>   "Failed to create KVM VFIO device: No such device"

Applied to queue.

	M.
-- 
Jazz is not dead. It just smells funny...
