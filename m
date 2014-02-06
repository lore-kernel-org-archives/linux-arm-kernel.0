From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 6 Feb 2014 11:01:48 +0000
Subject: [PATCH v3 09/11] ARM: KVM: introduce per-vcpu HYP
 Configuration Register
In-Reply-To: <1391630151-7875-10-git-send-email-marc.zyngier@arm.com>
References: <1391630151-7875-1-git-send-email-marc.zyngier@arm.com>
 <1391630151-7875-10-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140206110147.GF29446@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 07:55:49PM +0000, Marc Zyngier wrote:
> So far, KVM/ARM used a fixed HCR configuration per guest, except for
> the VI/VF/VA bits to control the interrupt in absence of VGIC.
> 
> With the upcoming need to dynamically reconfigure trapping, it becomes
> necessary to allow the HCR to be changed on a per-vcpu basis.
> 
> The fix here is to mimic what KVM/arm64 already does: a per vcpu HCR
> field, initialized at setup time.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
