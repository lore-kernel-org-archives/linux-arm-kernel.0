From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 15 Jan 2015 12:04:54 +0100
Subject: [PATCH v6 2/4] KVM: introduce kvm_arch_intc_initialized
In-Reply-To: <1421170420-30617-3-git-send-email-eric.auger@linaro.org>
References: <1421170420-30617-1-git-send-email-eric.auger@linaro.org>
 <1421170420-30617-3-git-send-email-eric.auger@linaro.org>
Message-ID: <20150115110454.GP26222@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 06:33:38PM +0100, Eric Auger wrote:
> Introduce __KVM_HAVE_ARCH_INTC_INITIALIZED define and
> associated kvm_arch_intc_initialized function. This latter
> allows to test whether the virtual interrupt controller is initialized
> and ready to accept virtual IRQ injection. On some architectures,
> the virtual interrupt controller is dynamically instantiated, justifying
> that kind of check.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> 
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
