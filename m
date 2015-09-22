From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 22 Sep 2015 19:23:48 +0100
Subject: [PATCH v7 1/6] arm: add msi.h to Kbuild
In-Reply-To: <1442801587-3812-2-git-send-email-lftan@altera.com>
References: <1442801587-3812-1-git-send-email-lftan@altera.com>
 <1442801587-3812-2-git-send-email-lftan@altera.com>
Message-ID: <20150922192348.1c9814c8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Sep 2015 10:13:02 +0800
Ley Foon Tan <lftan@altera.com> wrote:

> Include asm-generic/msi.h to support CONFIG_GENERIC_MSI_IRQ_DOMAIN.
> This to fix compilation error:
> "include/linux/msi.h:123:21: fatal error: asm/msi.h:
> No such file or directory"
> 
> Signed-off-by: Ley Foon Tan <lftan@altera.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
