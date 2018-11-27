From: rafael.tinoco@linaro.org (Rafael David Tinoco)
Date: Tue, 27 Nov 2018 18:33:29 -0200
Subject: [PATCH v2] mm/zsmalloc.c: Fix zsmalloc 32-bit PAE support
In-Reply-To: <91776bf8-0d12-1cc4-1ffb-ca3c486aeb0b@linaro.org>
References: <20181025134344.GZ30658@n2100.armlinux.org.uk>
 <20181121001150.405-1-rafael.tinoco@linaro.org>
 <91776bf8-0d12-1cc4-1ffb-ca3c486aeb0b@linaro.org>
Message-ID: <93b0cce5-4ceb-14ab-5987-af54f15958f2@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/18 10:18 PM, Rafael David Tinoco wrote:
> 
> Russell,
> 
> I have tried to place MAX_POSSIBLE_PHYSMEM_BITS in the best available
> header for each architecture, considering different paging levels, PAE
> existence, and existing similar definitions. Also, I have only
> considered those architectures already having "sparsemem.h" header.
> 
> Would you mind reviewing it ?

Should I re-send the this v2 (as v3) with complete list of
get_maintainer.pl ? I was in doubt because I'm touching headers from
several archs and I'm not sure who, if it is accepted, would merge it.

Thank you
-- 
Rafael D. Tinoco
Linaro Kernel Validation
