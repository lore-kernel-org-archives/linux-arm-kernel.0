From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 20 May 2014 13:35:48 +0100
Subject: [PATCH v4 07/20] KVM: ARM: vgic: abstract access to the ELRSR
 bitmap
In-Reply-To: <1400176719-31275-8-git-send-email-marc.zyngier@arm.com>
References: <1400176719-31275-1-git-send-email-marc.zyngier@arm.com>
 <1400176719-31275-8-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140520123548.GE5292@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 06:58:26PM +0100, Marc Zyngier wrote:
> Move the GICH_ELRSR access to its own functions, and add them to
> the vgic_ops structure.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
