From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 20 May 2014 13:50:15 +0100
Subject: [PATCH v4 15/20] KVM: ARM: vgic: revisit implementation of
 irqchip_in_kernel
In-Reply-To: <1400176719-31275-16-git-send-email-marc.zyngier@arm.com>
References: <1400176719-31275-1-git-send-email-marc.zyngier@arm.com>
 <1400176719-31275-16-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140520125015.GG5292@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 06:58:34PM +0100, Marc Zyngier wrote:
> So far, irqchip_in_kernel() was implemented by testing the value of
> vctrl_base, which worked fine with GICv2.
> 
> With GICv3, this field is useless, as we're using system registers
> instead of a emmory mapped interface. To solve this, add a boolean
> flag indicating if the we're using a vgic or not.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
