From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 6 Sep 2016 12:53:45 +0200
Subject: [PATCH v2 4/7] arm64: KVM: Make kvm_skip_instr32 available to HYP
In-Reply-To: <1473150527-4729-5-git-send-email-marc.zyngier@arm.com>
References: <1473150527-4729-1-git-send-email-marc.zyngier@arm.com>
 <1473150527-4729-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160906105345.GL30513@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 09:28:44AM +0100, Marc Zyngier wrote:
> As we plan to do some emulation at HYP, let's make kvm_skip_instr32
> as part of the hyp_text section. This doesn't preclude the kernel
> from using it.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
