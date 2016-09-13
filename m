From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 13 Sep 2016 10:51:48 +0200
Subject: [PATCH v4 04/10] KVM: arm64: vgic-its: Introduce config option
 to guard ITS specific code
In-Reply-To: <1473691764-29424-5-git-send-email-vladimir.murzin@arm.com>
References: <1473691764-29424-1-git-send-email-vladimir.murzin@arm.com>
 <1473691764-29424-5-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20160913085148.GE5680@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2016 at 03:49:18PM +0100, Vladimir Murzin wrote:
> By now ITS code guarded with KVM_ARM_VGIC_V3 config option which was
> introduced to hide everything specific to vgic-v3 from 32-bit world.
> We are going to support vgic-v3 in 32-bit world and KVM_ARM_VGIC_V3
> will gone, but we don't have support for ITS there yet and we need to
> continue keeping ITS away.
> Introduce the new config option to prevent ITS code being build in
> 32-bit mode when support for vgic-v3 is done.
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
