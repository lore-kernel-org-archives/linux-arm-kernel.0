From: cohuck@redhat.com (Cornelia Huck)
Date: Mon, 11 Dec 2017 13:29:09 +0100
Subject: [PATCH v3 10/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_translate
In-Reply-To: <20171204203538.8370-11-cdall@kernel.org>
References: <20171204203538.8370-1-cdall@kernel.org>
 <20171204203538.8370-11-cdall@kernel.org>
Message-ID: <20171211132909.73b1b2fe.cohuck@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon,  4 Dec 2017 21:35:32 +0100
Christoffer Dall <cdall@kernel.org> wrote:

> From: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Move vcpu_load() and vcpu_put() into the architecture specific
> implementations of kvm_arch_vcpu_ioctl_translate().
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/powerpc/kvm/booke.c | 2 ++
>  arch/x86/kvm/x86.c       | 3 +++
>  virt/kvm/kvm_main.c      | 2 --
>  3 files changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
