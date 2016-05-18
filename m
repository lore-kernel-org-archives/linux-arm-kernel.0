From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 18 May 2016 16:14:38 +0200
Subject: [PATCH v4 20/56] KVM: arm/arm64: vgic-new: Add GICv3 world
 switch backend
In-Reply-To: <1463392481-26583-21-git-send-email-andre.przywara@arm.com>
References: <1463392481-26583-1-git-send-email-andre.przywara@arm.com>
 <1463392481-26583-21-git-send-email-andre.przywara@arm.com>
Message-ID: <20160518141438.GB6666@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2016 at 10:53:08AM +0100, Andre Przywara wrote:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> As the GICv3 virtual interface registers differ from their GICv2
> siblings, we need different handlers for processing maintenance
> interrupts and reading/writing to the LRs.
> Implement the respective handler functions and connect them to
> existing code to be called if the host is using a GICv3.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
