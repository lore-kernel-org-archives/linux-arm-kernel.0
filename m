From: andre.przywara@arm.com (=?windows-1252?Q?Andr=E9_Przywara?=)
Date: Fri, 16 Jan 2015 09:36:00 +0000
Subject: [PATCH v7 3/4] KVM: arm/arm64: implement kvm_arch_intc_initialized
In-Reply-To: <1421333267-15287-4-git-send-email-eric.auger@linaro.org>
References: <1421333267-15287-1-git-send-email-eric.auger@linaro.org>
 <1421333267-15287-4-git-send-email-eric.auger@linaro.org>
Message-ID: <54B8DB80.50202@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/15/2015 02:47 PM, Eric Auger wrote:
> On arm/arm64 the VGIC is dynamically instantiated and it is useful
> to expose its state, especially for irqfd setup.
> 
> This patch defines __KVM_HAVE_ARCH_INTC_INITIALIZED and
> implements kvm_arch_intc_initialized.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre.
