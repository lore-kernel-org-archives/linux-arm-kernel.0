From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 18 Jul 2015 00:15:52 +0200
Subject: [PATCH v2 09/10] KVM: arm/arm64: timer: Allow the timer to
 control the active state
In-Reply-To: <1436378202-20224-10-git-send-email-marc.zyngier@arm.com>
References: <1436378202-20224-1-git-send-email-marc.zyngier@arm.com>
 <1436378202-20224-10-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150717221552.GM14024@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08, 2015 at 06:56:41PM +0100, Marc Zyngier wrote:
> In order to remove the crude hack where we sneak the masked bit
> into the timer's control register, make use of the phys_irq_map
> API control the active state of the interrupt.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
