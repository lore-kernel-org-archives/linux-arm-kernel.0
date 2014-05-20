From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 20 May 2014 13:53:50 +0100
Subject: [PATCH v4 17/20] arm64: KVM: split GICv2 world switch from hyp
 code
In-Reply-To: <1400176719-31275-18-git-send-email-marc.zyngier@arm.com>
References: <1400176719-31275-1-git-send-email-marc.zyngier@arm.com>
 <1400176719-31275-18-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140520125350.GH5292@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 06:58:36PM +0100, Marc Zyngier wrote:
> Move the GICv2 world switch code into its own file, and add the
> necessary indirection to the arm64 switch code.
> 
> Also introduce a new type field to the vgic_params structure.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
