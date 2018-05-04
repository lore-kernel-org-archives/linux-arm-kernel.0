From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 4 May 2018 09:45:33 +0100
Subject: [PATCH v7 2/2] PCI: mediatek: Using chained IRQ to setup IRQ
 handle
In-Reply-To: <1525412853-24367-3-git-send-email-honghui.zhang@mediatek.com>
References: <1525412853-24367-1-git-send-email-honghui.zhang@mediatek.com>
 <1525412853-24367-3-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <3a2c9b1a-613b-0816-48a9-e2048ed494b4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/05/18 06:47, honghui.zhang at mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> Using irq_chip solution to setup IRQs in order to consist
> with IRQ framework.
> 
> Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>

Thanks for going the extra mile and fixing this driver.

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
