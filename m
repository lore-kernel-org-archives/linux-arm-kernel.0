From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 13 Sep 2016 10:51:44 +0200
Subject: [PATCH v4 03/10] arm64: KVM: Move vgic-v3 save/restore to
 virt/kvm/arm/hyp
In-Reply-To: <1473691764-29424-4-git-send-email-vladimir.murzin@arm.com>
References: <1473691764-29424-1-git-send-email-vladimir.murzin@arm.com>
 <1473691764-29424-4-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20160913085144.GD5680@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2016 at 03:49:17PM +0100, Vladimir Murzin wrote:
> So we can reuse the code under arch/arm
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
