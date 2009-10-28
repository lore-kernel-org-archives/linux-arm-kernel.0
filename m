From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 28 Oct 2009 15:53:41 +0000
Subject: [RFC 00/11] Cache handling updates
In-Reply-To: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
References: <cover.1256683230.git.rmk+kernel@arm.linux.org.uk>
Message-ID: <1256745221.27121.50.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2009-10-27 at 22:40 +0000, Russell King wrote:
> Russell King (11):
>   ARM: Reduce __flush_dcache_page() visibility
>   ARM: Fix errata 411920 workarounds
>   ARM: move __flush_icache_all() out of flush_pfn_alias()
>   ARM: Remove __flush_icache_all() from __flush_dcache_page()
>   ARM: Avoid flush_dcache_page() for zero page
>   ARM: Avoid duplicated implementation for VIVT cache flushing
>   ARM: Allocate ZERO_PAGE from highmem
>   ARM: Avoid evaluating page_address() multiple times
>   ARM: Add I-cache invalidation for VIVT ASID tagged caches
>   ARM: arrange for flush_cache_range() to always flush the I-cache
>   ARM: avoid flushing I-cache in flush_cache_mm()

Apart from the comments I sent to the list, the other patches look ine
to me.

Thanks.

-- 
Catalin
