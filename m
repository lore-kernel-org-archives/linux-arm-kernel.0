From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Sep 2012 14:30:15 +0100
Subject: [PATCH v3 RESEND 09/17] ARM: LPAE: use phys_addr_t for initrd
 location and size
In-Reply-To: <1348242975-19184-10-git-send-email-cyril@ti.com>
References: <1348242975-19184-1-git-send-email-cyril@ti.com>
 <1348242975-19184-10-git-send-email-cyril@ti.com>
Message-ID: <20120924133015.GE23298@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 04:56:07PM +0100, Cyril Chemparathy wrote:
> From: Vitaly Andrianov <vitalya@ti.com>
> 
> This patch fixes the initrd setup code to use phys_addr_t instead of assuming
> 32-bit addressing.  Without this we cannot boot on systems where initrd is
> located above the 4G physical address limit.
> 
> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
> Acked-by: Nicolas Pitre <nico@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
