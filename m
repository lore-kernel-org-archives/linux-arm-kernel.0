From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 4 Aug 2015 16:33:46 +0200
Subject: [PATCH v3 04/11] KVM: arm/arm64: vgic: Allow HW irq to be
 encoded in LR
In-Reply-To: <1437753309-17989-5-git-send-email-marc.zyngier@arm.com>
References: <1437753309-17989-1-git-send-email-marc.zyngier@arm.com>
 <1437753309-17989-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150804143346.GE29335@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 04:55:02PM +0100, Marc Zyngier wrote:
> Now that struct vgic_lr supports the LR_HW bit and carries a hwirq
> field, we can encode that information into the list registers.
> 
> This patch provides implementations for both GICv2 and GICv3.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
