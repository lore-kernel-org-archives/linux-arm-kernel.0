From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 11 Sep 2014 15:37:35 -0700
Subject: [PATCH v4 6/8] arm/arm64: KVM: vgic: kill VGIC_NR_IRQS
In-Reply-To: <1410433755-3612-7-git-send-email-marc.zyngier@arm.com>
References: <1410433755-3612-1-git-send-email-marc.zyngier@arm.com>
 <1410433755-3612-7-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140911223735.GR5535@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 11, 2014 at 12:09:13PM +0100, Marc Zyngier wrote:
> Nuke VGIC_NR_IRQS entierly, now that the distributor instance
> contains the number of IRQ allocated to this GIC.
> 
> Also add VGIC_NR_IRQS_LEGACY to preserve the current API.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Did anything dramtically change in this patch since last time around?

If not, I'll re-affirm my tag:

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>

Thanks,
-Christoffer
