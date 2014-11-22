From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 22 Nov 2014 18:08:33 +0100
Subject: [PATCH v14 1/7] KVM: Add architecture-defined TLB flush support
In-Reply-To: <1415930268-7674-2-git-send-email-m.smarduch@samsung.com>
References: <1415930268-7674-1-git-send-email-m.smarduch@samsung.com>
 <1415930268-7674-2-git-send-email-m.smarduch@samsung.com>
Message-ID: <20141122170833.GK3401@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 05:57:42PM -0800, Mario Smarduch wrote:
> Allow architectures to override the generic kvm_flush_remote_tlbs()
> function via HAVE_KVM_ARCH_TLB_FLUSH_ALL. ARMv7 will need this to
> provide its own TLB flush interface.
> 
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Mario Smarduch <m.smarduch@samsung.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
