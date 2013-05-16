From: borntraeger@de.ibm.com (Christian Borntraeger)
Date: Thu, 16 May 2013 13:00:21 +0200
Subject: [PATCH v3 2/2] KVM: get rid of $(addprefix ../../../virt/kvm/,
 ...) in Makefiles
In-Reply-To: <1368538262-25546-3-git-send-email-marc.zyngier@arm.com>
References: <1368538262-25546-1-git-send-email-marc.zyngier@arm.com>
 <1368538262-25546-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <5194BC45.6070103@de.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/05/13 15:31, Marc Zyngier wrote:
> As requested by the KVM maintainers, remove the addprefix used to
> refer to the main KVM code from the arch code, and replace it with
> a KVM variable that does the same thing.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Gleb Natapov <gleb@redhat.com>
> Cc: Christoffer Dall <cdall@cs.columbia.edu>
> Acked-by: Xiantao Zhang <xiantao.zhang@intel.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>

s390 part:
Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>

> Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/kvm/Makefile     |  2 +-
>  arch/ia64/kvm/Makefile    |  7 ++++---
>  arch/powerpc/kvm/Makefile | 13 +++++++------
>  arch/s390/kvm/Makefile    |  3 ++-
>  arch/x86/kvm/Makefile     | 13 +++++++------
>  5 files changed, 21 insertions(+), 17 deletions(-)
