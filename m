From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 15 Apr 2014 09:15:51 +0100
Subject: [PATCHv2 8/8] ARM: dts: Add device tree sources for Exynos3250
In-Reply-To: <1397527192-21988-9-git-send-email-cw00.choi@samsung.com>
References: <1397527192-21988-1-git-send-email-cw00.choi@samsung.com>
 <1397527192-21988-9-git-send-email-cw00.choi@samsung.com>
Message-ID: <534CEAB7.6020600@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/04/14 02:59, Chanwoo Choi wrote:
> From: Tomasz Figa <t.figa@samsung.com>
> 
> This patch add new exynos3250.dtsi to support Exynos3250 SoC based on Cortex-A7
> dual core and includes following dt nodes:
> 
> - GIC interrupt controller
> - Pinctrl to control GPIOs
> - Clock controller
> - CPU information (Cortex-A7 dual core)
> - UART to support serial port
> - MCT (Multi Core Timer)
> - ADC (Analog Digital Converter)
> - I2C/SPI bus
> - Power domain
> - PMU (Performance Monitoring Unit)
> - MSHC (Mobile Storage Host Controller)
> - PWM (Pluse Width Modulation)
> - AMBA bus

[...]

Where is the arch timer node?

	M.
-- 
Jazz is not dead. It just smells funny...
