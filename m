From: pbonzini@redhat.com (Paolo Bonzini)
Date: Thu, 30 May 2013 07:45:51 +0200
Subject: [GIT PULL] KVM/ARM Fixes for 3.10
In-Reply-To: <CAMJs5B8qTMpaaq0y=xGUrTzUd_-LvmARdGABV8PdpqmWUkPoqw@mail.gmail.com>
References: <CAMJs5B8qTMpaaq0y=xGUrTzUd_-LvmARdGABV8PdpqmWUkPoqw@mail.gmail.com>
Message-ID: <51A6E78F.3070902@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 30/05/2013 03:39, Christoffer Dall ha scritto:
> The following changes since commit e47a5f5fb715b90b40747e9e235de557c6abd56c:
> 
>   KVM: x86 emulator: convert XADD to fastop (2013-05-21 15:43:24 +0300)

Chris,

this is based on the "next" branch, which will not be merged until the
3.11 merge window.  Please base your 3.10 fixes on the "master" branch
of kvm.git.

Thanks!

Paolo

> are available in the git repository at:
> 
>   git://github.com/columbia/linux-kvm-arm.git kvm-arm-fixes-3.10
> 
> for you to fetch changes up to f3afcd8bf501e98e7707865930338e5a82d8ed88:
> 
>   ARM: KVM: be more thorough when invalidating TLBs (2013-05-27 19:34:20 -0700)
> 
> ----------------------------------------------------------------
> Andre Przywara (1):
>       ARM: KVM: prevent NULL pointer dereferences with KVM VCPU ioctl
> 
> Marc Zyngier (1):
>       ARM: KVM: be more thorough when invalidating TLBs
> 
>  arch/arm/kvm/arm.c |   15 +++++++++++++--
>  arch/arm/kvm/mmu.c |   41 ++++++++++++++++++++++++++---------------
>  2 files changed, 39 insertions(+), 17 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
