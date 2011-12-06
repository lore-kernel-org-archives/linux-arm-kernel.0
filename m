From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 6 Dec 2011 14:41:49 -0500 (EST)
Subject: [PATCH] highmem: Fix ARM build break due to __kmap_atomic rename
In-Reply-To: <1323197426-10815-1-git-send-email-swarren@nvidia.com>
References: <1323197426-10815-1-git-send-email-swarren@nvidia.com>
Message-ID: <alpine.LFD.2.02.1112061440050.2357@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Dec 2011, Stephen Warren wrote:

> Git commit 37bfbb9 "highmem: kill all __kmap_atomic()" renamed
> __kmap_atomic to kmap_atomic. However, arch/arm/include/asm/highmem.h
> wasn't updated for that change. This change does so, and fixes the
> ARM build break.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> This shows up in next-20111206 at least.

Commit 37bfbb9 doesn't show up in anything which is stable yet.  Would 
be best to ask the original author to fix his branch.


Nicolas
