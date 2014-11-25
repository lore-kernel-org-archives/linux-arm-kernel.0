From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 25 Nov 2014 11:27:29 +0000
Subject: [PATCH v8 1/4] irqchip: gic: Support hierarchy irq domain.
In-Reply-To: <1416902662-19281-2-git-send-email-yingjoe.chen@mediatek.com>
References: <1416902662-19281-1-git-send-email-yingjoe.chen@mediatek.com>
 <1416902662-19281-2-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <547467A1.8000900@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/11/14 08:04, Yingjoe Chen wrote:
> Add support to use gic as a parent for stacked irq domain.
> 
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>

Looks good to me.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
