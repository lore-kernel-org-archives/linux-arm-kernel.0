From: rkrcmar@redhat.com (Radim =?utf-8?B?S3LEjW3DocWZ?=)
Date: Wed, 28 Mar 2018 22:00:34 +0200
Subject: [GIT PULL] KVM/ARM updates for v4.17
In-Reply-To: <20180328125254.31380-1-marc.zyngier@arm.com>
References: <20180328125254.31380-1-marc.zyngier@arm.com>
Message-ID: <20180328200033.GA26753@flask>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-03-28 13:51+0100, Marc Zyngier:
> Paolo, Radim,
> 
> This is the (rather big) set of updates for KVM/ARM for v4.17. The
> main features are the set of VHE optimizations taking advantage of
> CPUs implementing ARMv8.1, together with the EL2 randomization patches
> that are the foundation for mitigating the so-called variant 3a
> security issue (affecting Cortex-A57 and A72).
> 
> The rest is the usual mix of vgic fixes and minor improvements.
> 
> Note that the breakup below is slightly misleading, as it includes
> fixes that have already landed in mainline (I've done a direct merge
> of the fixes branch in order to spare everyone some horrible
> conflicts).
> 
> Also, we've had to revert a pretty important patch for Qualcomm
> servers due to some more conflicts with the arm64 tree). That patch
> will be resent once both trees have been pulled into Linus' (the
> sooner, the better).

KVM tree will likely be merged in the latter half of next week.

> Please pull.

Pulled, thanks.
