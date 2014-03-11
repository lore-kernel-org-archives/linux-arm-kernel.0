From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 11 Mar 2014 12:08:45 +0000
Subject: [PATCH v6 0/6] mm: generic early_ioremap support
In-Reply-To: <1394384444-23182-1-git-send-email-msalter@redhat.com>
References: <1394384444-23182-1-git-send-email-msalter@redhat.com>
Message-ID: <20140311120845.GG31104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Sun, Mar 09, 2014 at 05:00:38PM +0000, Mark Salter wrote:
> This patch series takes the common bits from the x86 early ioremap
> implementation and creates a generic implementation which may be used
> by other architectures. The early ioremap interfaces are intended for
> situations where boot code needs to make temporary virtual mappings
> before the normal ioremap interfaces are available. Typically, this
> means before paging_init() has run.
> 
> These patches are layered on top of generic fixmap patches which
> were pulled into upstream 3.14-rc kernels.
> 
> This is version 6 of the patch series. These patches fixmap patches
> may be found at:
> 
>   git://github.com/mosalter/linux.git (early-ioremap-v6 branch)

Are there any acks still needed? I think the arch patches in this series
have been acked, so I'm happy if hpa or someone else takes the whole
series.

Thanks.

-- 
Catalin
