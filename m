From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 22 Jun 2015 15:48:32 -0700
Subject: [PATCH v3 0/3] clk: stm32: Add clock driver for STM32F4[23]xxx
 devices
In-Reply-To: <1433966978-24422-1-git-send-email-daniel.thompson@linaro.org>
References: <1432327273-6810-1-git-send-email-daniel.thompson@linaro.org>
 <1433966978-24422-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <20150622224832.GI22132@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10, Daniel Thompson wrote:
> This patchset implements a clock driver for STM32F42xxx and STM32F43xxx
> series devices. It supports decoding the state configured by the
> bootloader (PLL, clock select, bus dividers) and all the gates clocks.
> It does not currently support the I2S and SAI PLLs.
> 
> Relies on "Add support to STMicroeletronics STM32 family" v9 by Maxime
> Coquelin: http://thread.gmane.org/gmane.linux.kernel/1961049 .
> 

I applied 1 and 2. Looks like #3 should go through arm-soc at
some later time?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
