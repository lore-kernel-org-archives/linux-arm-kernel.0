From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 20 May 2014 13:41:34 +0100
Subject: [PATCH v4 11/20] KVM: ARM: vgic: abstract VMCR access
In-Reply-To: <1400176719-31275-12-git-send-email-marc.zyngier@arm.com>
References: <1400176719-31275-1-git-send-email-marc.zyngier@arm.com>
 <1400176719-31275-12-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140520124134.GF5292@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 06:58:30PM +0100, Marc Zyngier wrote:
> Instead of directly messing with with the GICH_VMCR bits for the CPU
> interface save/restore code, add accessors that encode/decode the
> entire set of registers exposed by VMCR.
> 
> Not the most efficient thing, but given that this code is only used
> by the save/restore code, performance is far from being critical.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
