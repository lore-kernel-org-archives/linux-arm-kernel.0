From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 20 May 2014 13:33:30 +0100
Subject: [PATCH v4 06/20] KVM: ARM: vgic: introduce vgic_ops and LR
 manipulation primitives
In-Reply-To: <1400176719-31275-7-git-send-email-marc.zyngier@arm.com>
References: <1400176719-31275-1-git-send-email-marc.zyngier@arm.com>
 <1400176719-31275-7-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140520123330.GD5292@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 06:58:25PM +0100, Marc Zyngier wrote:
> In order to split the various register manipulation from the main vgic
> code, introduce a vgic_ops structure, and start by abstracting the
> LR manipulation code with a couple of accessors.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
