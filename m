From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 6 Sep 2016 12:47:25 +0200
Subject: [PATCH v2 1/7] arm64: KVM: Move kvm_vcpu_get_condition out of
 emulate.c
In-Reply-To: <1473150527-4729-2-git-send-email-marc.zyngier@arm.com>
References: <1473150527-4729-1-git-send-email-marc.zyngier@arm.com>
 <1473150527-4729-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160906104725.GJ30513@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 09:28:41AM +0100, Marc Zyngier wrote:
> In order to make emulate.c more generic, move the arch-specific
> manupulation bits out of emulate.c.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
