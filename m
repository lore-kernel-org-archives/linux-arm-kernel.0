From: pbonzini@redhat.com (Paolo Bonzini)
Date: Mon, 11 Nov 2013 12:31:47 +0100
Subject: [GIT PULL] Third and final KVM/ARM updates for 3.13
In-Reply-To: <1383874322-12328-1-git-send-email-christoffer.dall@linaro.org>
References: <1383874322-12328-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <5280C023.4080203@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 08/11/2013 02:31, Christoffer Dall ha scritto:
> The following changes since commit e4b3c9c21bd5674e96988f7507fd924e00087cd0:
> 
>   Merge branch 'kvm-arm-next-3.13-2' into kvm-arm-next (2013-10-17 20:41:44 -0700)
> 
> are available in the git repository at:
> 
> 
>   git://git.linaro.org/people/cdall/linux-kvm-arm.git tags/kvm-arm-for-3.13-3
> 
> for you to fetch changes up to 79c648806f9034abf54332b78043bb242189d953:
> 
>   arm/arm64: KVM: PSCI: use MPIDR to identify a target CPU (2013-10-22 08:00:06 -0700)
> 
> Sorry about sending this out so late.  It has been in linux-next for a
> while and is well-tested.
> 
> ----------------------------------------------------------------
> Updates for KVM/ARM, take 3 supporting more than 4 CPUs.
> 
> ----------------------------------------------------------------
> Marc Zyngier (4):
>       ARM: KVM: Fix MPIDR computing to support virtual clusters
>       ARM: KVM: fix L2CTLR to be per-cluster
>       ARM: KVM: drop limitation to 4 CPU VMs
>       arm/arm64: KVM: PSCI: use MPIDR to identify a target CPU
> 
>  arch/arm/include/asm/kvm_emulate.h   |    5 +++++
>  arch/arm/kvm/coproc.c                |   14 ++++++++++----
>  arch/arm/kvm/psci.c                  |   17 +++++++++++++----
>  arch/arm/kvm/reset.c                 |    4 ----
>  arch/arm64/include/asm/kvm_emulate.h |    5 +++++
>  5 files changed, 33 insertions(+), 12 deletions(-)
> 

Pulled, thanks.

Paolo
