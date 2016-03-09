From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 8 Mar 2016 19:12:24 -0800
Subject: [PATCH v3 11/12] arm64: KVM: vgic-v3: Reset LRs at boot time
In-Reply-To: <1457343214-19547-12-git-send-email-marc.zyngier@arm.com>
References: <1457343214-19547-1-git-send-email-marc.zyngier@arm.com>
 <1457343214-19547-12-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160309031224.GC26583@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 07, 2016 at 09:33:33AM +0000, Marc Zyngier wrote:
> In order to let the GICv3 code be more lazy in the way it
> accesses the LRs, it is necessary to start with a clean slate.
> 
> Let's reset the LRs on each CPU when the vgic is probed (which
> includes a round trip to EL2...).
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
