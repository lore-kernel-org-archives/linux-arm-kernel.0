From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 7 Jan 2014 17:26:32 +0000
Subject: [PATCH v2 0/5] generic early_ioremap support
In-Reply-To: <1389062120-31896-1-git-send-email-msalter@redhat.com>
References: <1389062120-31896-1-git-send-email-msalter@redhat.com>
Message-ID: <20140107172632.GC6234@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 02:35:15AM +0000, Mark Salter wrote:
> This patch series takes the common bits from the x86 early ioremap
> implementation and creates a generic implementation which may be used
> by other architectures. The early ioremap interfaces are intended for
> situations where boot code needs to make temporary virtual mappings
> before the normal ioremap interfaces are available. Typically, this
> means before paging_init() has run.
> 
> These patches are layered on top of generic fixmap patches which
> were discussed here (and are in the akpm tree):
> 
>   http://lkml.org/lkml/2013/11/25/474
> 
> This is version 2 of the patch series. These patches (and underlying
> fixmap patches) may be found at:
> 
>   git://github.com/mosalter/linux.git (early-ioremap-v2 branch)

The patches look fine to me. I haven't acked the arm64 patches as I'll
eventually merge/sign them off once the first patch in the series goes
in.

Thanks.

-- 
Catalin
