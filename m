From: cdall@linaro.org (Christoffer Dall)
Date: Tue, 16 May 2017 11:53:18 +0200
Subject: [PATCH v3 0/2] kvm: arm/arm64: Fixes for race conditions
In-Reply-To: <1494927295-29369-1-git-send-email-suzuki.poulose@arm.com>
References: <1494927295-29369-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20170516095318.GA5259@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 16, 2017 at 10:34:53AM +0100, Suzuki K Poulose wrote:
> The patches fixes race conditions in stage2 pgd accesses.
> 
> Patch 1 is a fix up for the patch which has already been pushed to
> kvmarm/master.
> 
> Patch 2 fixes a case where stage2 PGD could be free'd when we release
> the kvm->mmu_lock to prevent VCPU starvation.
> 
> Applies on kvmarm/master tree

Thanks for the rebase and fix.

Applied to master, and for both patches::

Reviewed-by: Christoffer Dall <cdall@linaro.org>
