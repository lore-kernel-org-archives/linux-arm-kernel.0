From: gleb@redhat.com (Gleb Natapov)
Date: Tue, 19 Nov 2013 10:29:07 +0200
Subject: [GIT PULL] Fix vmalloc allocations for KVM/ARM
In-Reply-To: <1384809194-9301-1-git-send-email-christoffer.dall@linaro.org>
References: <1384809194-9301-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <20131119082907.GW2008@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 01:13:13PM -0800, Christoffer Dall wrote:
> Hi Gleb and Paolo,
> 
Pulled, thanks.

> Please pull this into kvm/master:
> 
> The following changes since commit 5e01dc7b26d9f24f39abace5da98ccbd6a5ceb52:
> 
>   Linux 3.12 (2013-11-03 15:41:51 -0800)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/cdall/linux-kvm-arm.git tags/kvm-arm-fixes-3.13-1
> 
> for you to fetch changes up to 40c2729bab48e2832b17c1fa8af9db60e776131b:
> 
>   arm/arm64: KVM: Fix hyp mappings of vmalloc regions (2013-11-16 18:54:45 -0800)
> 
> ----------------------------------------------------------------
> Fix percpu vmalloc allocations
> 
> ----------------------------------------------------------------
> Christoffer Dall (1):
>       arm/arm64: KVM: Fix hyp mappings of vmalloc regions
> 
>  arch/arm/kvm/mmu.c |   34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)

--
			Gleb.
