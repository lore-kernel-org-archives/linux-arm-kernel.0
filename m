From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Wed, 14 May 2014 21:36:47 +0200
Subject: [PATCHv5 5/5] ARM: dts: Add device tree sources for Exynos3250
In-Reply-To: <1399986308-23744-6-git-send-email-cw00.choi@samsung.com>
References: <1399986308-23744-1-git-send-email-cw00.choi@samsung.com>
 <1399986308-23744-6-git-send-email-cw00.choi@samsung.com>
Message-ID: <5373C5CF.4040002@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 13.05.2014 15:05, Chanwoo Choi wrote:
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
> - sysram node for SYSRAM memory mapping

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
