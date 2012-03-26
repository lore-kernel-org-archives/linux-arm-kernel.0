From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 26 Mar 2012 11:38:54 +0100
Subject: [PATCH] ARM: fixup section mismatch warning for alloc_init_pud()
In-Reply-To: <87398zswkj.wl%kuninori.morimoto.gx@renesas.com>
References: <87398zswkj.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20120326103854.GG30455@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 23, 2012 at 05:41:52AM +0000, Kuninori Morimoto wrote:
> This patch fixup below warning
> 
> WARNING: arch/arm/mm/built-in.o(.text+0x2320):
> Section mismatch in reference from the function alloc_init_pud()
> to the function .init.text:alloc_init_section()
> The function alloc_init_pud() references
> the function __init alloc_init_section().
> This is often because alloc_init_pud lacks a __init
> annotation or the annotation of alloc_init_section is wrong.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
