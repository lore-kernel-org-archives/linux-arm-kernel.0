From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 27 Dec 2017 16:37:37 +0000
Subject: [PATCH v9 9/9] KVM: arm/arm64: Delete outdated forwarded irq
 documentation
In-Reply-To: <20171220113606.7030-10-christoffer.dall@linaro.org>
References: <20171220113606.7030-1-christoffer.dall@linaro.org>
 <20171220113606.7030-10-christoffer.dall@linaro.org>
Message-ID: <86bmikqg8e.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Dec 2017 11:36:06 +0000,
Christoffer Dall wrote:
> 
> The reason I added this documentation originally was that the concept of
> "never taking the interrupt", but just use the timer to generate an exit
> from the guest, was confusing to most, and we had to explain it several
> times over.  But as we can clearly see, we've failed to update the
> documentation as the code has evolved, and people who need to understand
> these details are probably better off reading the code.
> 
> Let's lighten our maintenance burden slightly and just get rid of this.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  Documentation/virtual/kvm/arm/vgic-mapped-irqs.txt | 187 ---------------------
>  1 file changed, 187 deletions(-)
>  delete mode 100644 Documentation/virtual/kvm/arm/vgic-mapped-irqs.txt

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
