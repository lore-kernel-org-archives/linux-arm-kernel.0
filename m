From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 9 Sep 2016 17:33:12 +0100
Subject: [PATCH v3 3/8] arm64: KVM: Move vgic-v3 save/restore to
 virt/kvm/arm/hyp
In-Reply-To: <1473350810-10857-4-git-send-email-vladimir.murzin@arm.com>
References: <1473350810-10857-1-git-send-email-vladimir.murzin@arm.com>
 <1473350810-10857-4-git-send-email-vladimir.murzin@arm.com>
Message-ID: <57D2E448.304@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/16 17:06, Vladimir Murzin wrote:
> So we can reuse the code under arch/arm
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
