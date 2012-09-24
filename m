From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Sep 2012 14:10:23 +0100
Subject: [PATCH v3 RESEND 07/17] ARM: LPAE: use phys_addr_t in
 alloc_init_pud()
In-Reply-To: <1348242975-19184-8-git-send-email-cyril@ti.com>
References: <1348242975-19184-1-git-send-email-cyril@ti.com>
 <1348242975-19184-8-git-send-email-cyril@ti.com>
Message-ID: <20120924131023.GC23298@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 04:56:05PM +0100, Cyril Chemparathy wrote:
> From: Vitaly Andrianov <vitalya@ti.com>
> 
> This patch fixes the alloc_init_pud() function to use phys_addr_t instead of
> unsigned long when passing in the phys argument.
> 
> This is an extension to commit 97092e0c56830457af0639f6bd904537a150ea4a (ARM:
> pgtable: use phys_addr_t for physical addresses), which applied similar changes
> elsewhere in the ARM memory management code.
> 
> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
> Acked-by: Nicolas Pitre <nico@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
