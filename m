From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 1 Sep 2016 12:27:48 +0200
Subject: [PATCH] KVM: arm: vgic: Drop build compatibility hack for older
 kernel versions
In-Reply-To: <1472579659-20772-1-git-send-email-marc.zyngier@arm.com>
References: <1472579659-20772-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160901102748.GB10162@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 06:54:19PM +0100, Marc Zyngier wrote:
> As kvm_set_routing_entry() was changing prototype between 4.7 and 4.8,
> an ugly hack was put in place in order to survive both building in
> -next and the merge window.
> 
> Now that everything has been merged, let's dump the compatibility
> hack for good.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Applied, thanks.

  -Christoffer
