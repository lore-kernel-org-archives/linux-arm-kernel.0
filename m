From: will.deacon@arm.com (Will Deacon)
Date: Tue, 1 Jul 2014 19:24:03 +0100
Subject: [PATCH v6 20/21] arm64: KVM: vgic: add GICv3 world switch
In-Reply-To: <1404140510-5382-21-git-send-email-marc.zyngier@arm.com>
References: <1404140510-5382-1-git-send-email-marc.zyngier@arm.com>
 <1404140510-5382-21-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140701182402.GA28164@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 30, 2014 at 04:01:49PM +0100, Marc Zyngier wrote:
> Introduce the GICv3 world switch code used to save/restore the
> GICv3 context.
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/kvm_asm.h |   2 +
>  arch/arm64/kernel/asm-offsets.c  |   8 ++
>  arch/arm64/kvm/vgic-v3-switch.S  | 238 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 248 insertions(+)

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
