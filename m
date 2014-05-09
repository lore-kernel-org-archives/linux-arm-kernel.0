From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 9 May 2014 16:05:45 +0200
Subject: [PATCH v3 05/19] KVM: arm/arm64: vgic: move GICv2 registers to
 their own structure
In-Reply-To: <1397655591-2761-6-git-send-email-marc.zyngier@arm.com>
References: <1397655591-2761-1-git-send-email-marc.zyngier@arm.com>
 <1397655591-2761-6-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140509140545.GF3362@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 02:39:37PM +0100, Marc Zyngier wrote:
> In order to make way for the GICv3 registers, move the v2-specific
> registers to their own structure.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
