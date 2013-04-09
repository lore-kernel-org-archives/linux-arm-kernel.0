From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Tue, 9 Apr 2013 11:31:24 -0700
Subject: [PATCH 0/2] ARM: KVM: pre-KVM/arm64 patches
In-Reply-To: <1365436039-29564-1-git-send-email-marc.zyngier@arm.com>
References: <1365436039-29564-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAEDV+gL+ur+hC1EvKUcEkQ5_YkqvrZ3VYbFRJ=c7xyu2hOYMVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 8, 2013 at 8:47 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> This series contains two small changes to KVM/ARM, in preparation for
> the arm64 patches. None of these changes actually affect the 32bit
> implementation.
>
> This has been tested on both arm (VE TC2) and arm64 (Foundation Model).
>
> Marc Zyngier (2):
>   ARM: KVM: add architecture specific hook for capabilities
>   ARM: KVM: promote vfp_host pointer to generic host cpu context

they look good to me, I can just do that rename Peter pointed out when
applying them, thanks.


>
>  arch/arm/include/asm/kvm_host.h | 13 ++++++++++---
>  arch/arm/kernel/asm-offsets.c   |  2 +-
>  arch/arm/kvm/arm.c              | 30 +++++++++++++++---------------
>  3 files changed, 26 insertions(+), 19 deletions(-)
>
> --
> 1.8.1.4
>
>
