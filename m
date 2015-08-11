From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 11 Aug 2015 00:42:37 -0700
Subject: [PATCH v4 06/11] KVM: arm/arm64: vgic: Allow dynamic mapping of
 physical/virtual interrupts
In-Reply-To: <1438962347-17541-7-git-send-email-marc.zyngier@arm.com>
References: <1438962347-17541-1-git-send-email-marc.zyngier@arm.com>
 <1438962347-17541-7-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150811074221.GC5007@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 07, 2015 at 04:45:42PM +0100, Marc Zyngier wrote:
> In order to be able to feed physical interrupts to a guest, we need
> to be able to establish the virtual-physical mapping between the two
> worlds.
> 
> The mappings are kept in a set of RCU lists, indexed by virtual interrupts.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks for addressing all my concerns:

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
