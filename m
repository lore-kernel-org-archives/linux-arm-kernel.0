From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 9 Sep 2016 17:46:38 +0100
Subject: [PATCH v3 4/8] KVM: arm64: vgic-its: Introduce config option to
 guard ITS specific code
In-Reply-To: <1473350810-10857-5-git-send-email-vladimir.murzin@arm.com>
References: <1473350810-10857-1-git-send-email-vladimir.murzin@arm.com>
 <1473350810-10857-5-git-send-email-vladimir.murzin@arm.com>
Message-ID: <57D2E76E.2000607@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/16 17:06, Vladimir Murzin wrote:
> By now ITS code guarded with KVM_ARM_VGIC_V3 config option which was
> introduced to hide everything specific to vgic-v3 from 32-bit world.
> We are going to support vgic-v3 in 32-bit world and KVM_ARM_VGIC_V3
> will gone, but we don't have support for ITS there yet and we need to
> continue keeping ITS away.
> Introduce the new config option to prevent ITS code being build in
> 32-bit mode when support for vgic-v3 is done.
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
