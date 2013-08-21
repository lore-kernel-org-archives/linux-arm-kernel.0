From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 21 Aug 2013 18:15:47 +0100
Subject: [PATCH] ARM64: include: asm: include "asm/types.h" in
 "pgtable-2level-types.h" and "pgtable-3level-types.h"
In-Reply-To: <52148D59.5090603@asianux.com>
References: <52148D59.5090603@asianux.com>
Message-ID: <20130821171547.GE6361@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 10:50:17AM +0100, Chen Gang wrote:
> Need include "asm/types.h", just like arm has done, or can not pass
> compiling, the related error:
> 
>   In file included from arch/arm64/include/asm/page.h:37:0,
>                    from drivers/staging/lustre/include/linux/lnet/linux/lib-lnet.h:42,
>                    from drivers/staging/lustre/include/linux/lnet/lib-lnet.h:44,
>                    from drivers/staging/lustre/lnet/lnet/api-ni.c:38:
>   arch/arm64/include/asm/pgtable-2level-types.h:19:1: error: unknown type name ?u64
>   arch/arm64/include/asm/pgtable-2level-types.h:20:1: error: unknown type name ?u64?
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>

Thanks.

-- 
Catalin
