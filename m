From: pbonzini@redhat.com (Paolo Bonzini)
Date: Mon, 8 Feb 2016 16:23:07 +0100
Subject: [GIT PULL] KVM/ARM updates for 4.5-rc2
In-Reply-To: <1453977038-13516-1-git-send-email-marc.zyngier@arm.com>
References: <1453977038-13516-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <56B8B2DB.9020407@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28/01/2016 11:30, Marc Zyngier wrote:
> Hi Paolo,
> 
> Please find below the KVM/ARM updates for 4.5-rc2. Mostly fixes as a
> result of Shannon's work on PMU emulation, which has outlined a few
> nits here and there, plus a correctness fix from Dave.
> 
> Please pull!
> 
> Thanks,
> 
> 	M.
> 
> The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:
> 
>   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-for-4.5-rc2
> 
> for you to fetch changes up to 6327f35a2010c06a3bc2bfb14202a38764fb9920:
> 
>   arm64: KVM: Fix guest dead loop when register accessor returns false (2016-01-24 21:56:01 +0000)
> 
> ----------------------------------------------------------------
> KVM/ARM fixes for v4.5-rc2
> 
> A few random fixes, mostly coming from the PMU work by Shannon:
> 
> - fix for injecting faults coming from the guest's userspace
> - cleanup for our CPTR_EL2 accessors (reserved bits)
> - fix for a bug impacting perf (user/kernel discrimination)
> - fix for a 32bit sysreg handling bug
> 
> ----------------------------------------------------------------

Finally pulled, thanks.

Paolo
