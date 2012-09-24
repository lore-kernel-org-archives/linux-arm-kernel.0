From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Sep 2012 14:09:51 +0100
Subject: [PATCH v3 RESEND 06/17] ARM: LPAE: use signed arithmetic for
 mask definitions
In-Reply-To: <1348242975-19184-7-git-send-email-cyril@ti.com>
References: <1348242975-19184-1-git-send-email-cyril@ti.com>
 <1348242975-19184-7-git-send-email-cyril@ti.com>
Message-ID: <20120924130951.GB23298@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 04:56:04PM +0100, Cyril Chemparathy wrote:
> This patch applies to PAGE_MASK, PMD_MASK, and PGDIR_MASK, where forcing
> unsigned long math truncates the mask at the 32-bits.  This clearly does bad
> things on PAE systems.
> 
> This patch fixes this problem by defining these masks as signed quantities.
> We then rely on sign extension to do the right thing.
> 
> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
> Reviewed-by: Nicolas Pitre <nico@linaro.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
