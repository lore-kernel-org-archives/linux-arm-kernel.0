From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 4 Jul 2014 02:42:36 -0700
Subject: [PATCH v6 19/21] KVM: ARM: vgic: add the GICv3 backend
In-Reply-To: <1404140510-5382-20-git-send-email-marc.zyngier@arm.com>
References: <1404140510-5382-1-git-send-email-marc.zyngier@arm.com>
 <1404140510-5382-20-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140704094236.GA20451@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 04:01:48PM +0100, Marc Zyngier wrote:
> Introduce the support code for emulating a GICv2 on top of GICv3
> hardware.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Yay, bisectability and called functions available and everything:

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
