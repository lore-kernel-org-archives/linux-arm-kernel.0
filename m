From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 15 Jan 2015 13:27:02 +0100
Subject: [PATCH v7 19/20] arm/arm64: KVM: allow userland to request a
 virtual GICv3
In-Reply-To: <1421253084-9663-20-git-send-email-andre.przywara@arm.com>
References: <1421253084-9663-1-git-send-email-andre.przywara@arm.com>
 <1421253084-9663-20-git-send-email-andre.przywara@arm.com>
Message-ID: <20150115122702.GW26222@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 04:31:23PM +0000, Andre Przywara wrote:
> With all of the GICv3 code in place now we allow userland to ask the
> kernel for using a virtual GICv3 in the guest.
> Also we provide the necessary support for guests setting the memory
> addresses for the virtual distributor and redistributors.
> This requires some userland code to make use of that feature and
> explicitly ask for a virtual GICv3.
> Document that KVM_CREATE_IRQCHIP only works for GICv2, but is
> considered legacy and using KVM_CREATE_DEVICE is preferred.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
