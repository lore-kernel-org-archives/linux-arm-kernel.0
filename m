From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 6 Sep 2016 12:47:19 +0200
Subject: [PATCH v2 2/7] arm64: KVM: Move the AArch32 conditional
 execution to common code
In-Reply-To: <1473150527-4729-3-git-send-email-marc.zyngier@arm.com>
References: <1473150527-4729-1-git-send-email-marc.zyngier@arm.com>
 <1473150527-4729-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160906104719.GI30513@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 09:28:42AM +0100, Marc Zyngier wrote:
> It would make some sense to share the conditional execution code
> between 32 and 64bit. In order to achieve this, let's move that
> code to virt/kvm/arm/aarch32.c. While we're at it, drop a
> superfluous BUG_ON() that wasn't that useful.
> 
> Following patches will migrate the 32bit port to that code base.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
