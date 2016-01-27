From: tony@atomide.com (Tony Lindgren)
Date: Wed, 27 Jan 2016 08:56:41 -0800
Subject: [PATCH] ARM: dts: am437x: pixcir_tangoc: use correct flags for
 irq types
In-Reply-To: <1451310759-29536-1-git-send-email-grygorii.strashko@ti.com>
References: <1451310759-29536-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20160127165641.GL19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grygorii Strashko <grygorii.strashko@ti.com> [151228 05:53]:
> Now IRQs for Pixcir Tangoc touchscreen are defined using
> IRQ_TYPE_NONE in am437x-gp-evm.dts and am43x-epos-evm.dts wich
> do not correspond HW.
> 
> Hence, update am437x-gp-evm.dts and am43x-epos-evm.dts files
> and use correct flag IRQ_TYPE_EDGE_FALLING for irq types.
> 
> While here, remove duplicated irq declaration for pixcir_ts at 5c node
> in am437x-gp-evm.dts.

Applying into omap-for-v4.5/fixes thanks.

Tony
