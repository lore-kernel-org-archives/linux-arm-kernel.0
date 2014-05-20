From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 20 May 2014 13:58:36 +0100
Subject: [PATCH v4 18/20] arm64: KVM: move HCR_EL2.{IMO, FMO} manipulation
 into the vgic switch code
In-Reply-To: <1400176719-31275-19-git-send-email-marc.zyngier@arm.com>
References: <1400176719-31275-1-git-send-email-marc.zyngier@arm.com>
 <1400176719-31275-19-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140520125836.GI5292@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 06:58:37PM +0100, Marc Zyngier wrote:
> GICv3 requires the IMO and FMO bits to be tightly coupled with some
> of the interrupt controller's register switch.
> 
> In order to have similar code paths, move the manipulation of these
> bits to the GICv2 switch code.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
