From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 15 May 2014 19:50:46 +0100
Subject: [PATCH v5 1/4] add ARMv7 HYP API to flush VM TLBs without
 address param
In-Reply-To: <53741FB2.30906@samsung.com>
References: <1399509616-4632-1-git-send-email-m.smarduch@samsung.com>
 <1399509616-4632-2-git-send-email-m.smarduch@samsung.com>
 <CAMJs5B_2N0FchTKFA_DtfCboJ0uRWCVtwzSJUPcezH78A7kC6A@mail.gmail.com>
 <53741FB2.30906@samsung.com>
Message-ID: <20140515185046.GA6164@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 14, 2014 at 07:00:18PM -0700, Mario Smarduch wrote:
> On 05/14/2014 09:47 AM, Christoffer Dall wrote:
> > On Wed, May 07, 2014 at 05:40:13PM -0700, Mario Smarduch wrote:

[...]

> >> +void kvm_flush_remote_tlbs(struct kvm *kvm)
> > 
> > This doesn't build?:
> 
> I reworked the patch series to build successfully after
> applying each patch. This patch was missing a weak 
> declaration of the function in virt/kvm/kvm_main.c.
> 
> I simplified some related code for PMD splitting
> reusing current mmu.c code, instead of reinventing. 
> I'll email new patch series tomorrow, you might not want 
> to waste your time on 2-4.
> 

ok, I'll review the new series.

Thanks,
-Christoffer
