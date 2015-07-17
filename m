From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 18 Jul 2015 00:15:47 +0200
Subject: [PATCH v2 08/10] KVM: arm/arm64: vgic: Add
 vgic_{get,set}_phys_irq_active
In-Reply-To: <1436378202-20224-9-git-send-email-marc.zyngier@arm.com>
References: <1436378202-20224-1-git-send-email-marc.zyngier@arm.com>
 <1436378202-20224-9-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150717221547.GL14024@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08, 2015 at 06:56:40PM +0100, Marc Zyngier wrote:
> In order to control the active state of an interrupt, introduce
> a pair of accessors allowing the state to be set/queried.
> 
> This only affects the logical state, and the HW state will only be
> applied at world-switch time.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
