From: dinguyen@kernel.org (Dinh Nguyen)
Date: Mon, 5 Mar 2018 09:25:04 -0600
Subject: [PATCH] arm64: dts: stratix10: enable i2c, add i2c periperals
In-Reply-To: <20180221202541.3258-1-atull@kernel.org>
References: <20180221202541.3258-1-atull@kernel.org>
Message-ID: <6661d0f4-79b5-91d2-7507-e15e7004ebe5@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alan,

On 02/21/2018 02:25 PM, Alan Tull wrote:
> Add clock for i2c
> Enable i2c1
> Set the i2c bus speed to 100KHz
> Add the following i2c peripherals
> * ds1339 RTC
> * 24c32 EEPROM
> * max1619 temperature monitor
> * ltc2497 ADC
>   * Add a fixed regulator for the ADC's Vref.
> 
> This requires Dinh Nguyen's Stratix10 clock driver
> ("clk: socfpga: stratix10: add clock driver for Stratix10 platform")
> 

Thanks for the patch! I've staged this patch based on the clock driver
patch.

Dinh
