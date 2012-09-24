From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 24 Sep 2012 14:09:21 +0100
Subject: [PATCH v3 RESEND 04/17] ARM: LPAE: use phys_addr_t on virt
 <--> phys conversion
In-Reply-To: <1348242975-19184-5-git-send-email-cyril@ti.com>
References: <1348242975-19184-1-git-send-email-cyril@ti.com>
 <1348242975-19184-5-git-send-email-cyril@ti.com>
Message-ID: <20120924130920.GA23298@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 21, 2012 at 04:56:02PM +0100, Cyril Chemparathy wrote:
> This patch fixes up the types used when converting back and forth between
> physical and virtual addresses.
> 
> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
> Reviewed-by: Nicolas Pitre <nico@linaro.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
