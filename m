From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Mar 2016 11:47:43 +0000
Subject: [PATCH v2 03/18] irqchip: versatile-fpga: add new arm,rps-irq
 compatible
In-Reply-To: <1457519060-6038-4-git-send-email-narmstrong@baylibre.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457519060-6038-1-git-send-email-narmstrong@baylibre.com>
 <1457519060-6038-4-git-send-email-narmstrong@baylibre.com>
Message-ID: <56E7F65F.7080606@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/16 10:24, Neil Armstrong wrote:
> Under the OX810SE, this exact same interface is used as "Reference Peripheral
> Specification" Interrupt Controller, so add a new compatible string.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
