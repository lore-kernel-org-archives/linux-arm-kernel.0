From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 09 Mar 2017 08:01:56 +0000
Subject: [PATCH v4 0/4] KVM: arm64: Increase number of user memslots
In-Reply-To: <1488953315-22375-1-git-send-email-linucherian@gmail.com>
 (linucherian@gmail.com's message of "Wed, 8 Mar 2017 11:38:31 +0530")
References: <1488953315-22375-1-git-send-email-linucherian@gmail.com>
Message-ID: <87zigux4i3.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 08 2017 at  6:08:31 am GMT, linucherian at gmail.com wrote:
> From: Linu Cherian <linu.cherian@cavium.com>
>
> v3 -> v4:
> - Add missing commit messages in patches 1 and 3
>
> v2 -> v3:
> - Added documentation for KVM_CAP_NR_MEMSLOTS
> - Removed KVM_PRIVATE_MEM_SLOTS which is unused
> - KVM_USER_MEM_SLOTS changed to 512 from 508
>  
> v1 -> v2:
> - Enabling KVM_CAP_NR_MEMSLOTS for arm/arm64 moved to separate patch.
> - Updated commit message so that what is reported to userspace is explicit.
>
>
> Linu Cherian (4):
>   KVM: Add documentation for KVM_CAP_NR_MEMSLOTS
>   KVM: arm/arm64: Enable KVM_CAP_NR_MEMSLOTS on arm/arm64
>   KVM: arm/arm64: Remove KVM_PRIVATE_MEM_SLOTS definition that are
>     unused
>   KVM: arm64: Increase number of user memslots to 512
>
>  Documentation/virtual/kvm/api.txt | 4 ++++
>  arch/arm/include/asm/kvm_host.h   | 1 -
>  arch/arm/kvm/arm.c                | 3 +++
>  arch/arm64/include/asm/kvm_host.h | 3 +--
>  4 files changed, 8 insertions(+), 3 deletions(-)

For the whole series:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Christoffer: if you're happy with this series, I'll take it as part of
the next batch of fixes.

Thanks,

	M.
-- 
Jazz is not dead, it just smell funny.
