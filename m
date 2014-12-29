From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Mon, 29 Dec 2014 11:14:52 -0800
Subject: [PATCH v2] ARM: config: multi_v7: Update it for Keystone defconfig
In-Reply-To: <20141229191159.GP29379@saruman>
References: <1419879089-3293-1-git-send-email-santosh.shilimkar@oracle.com>
 <20141229191159.GP29379@saruman>
Message-ID: <54A1A82C.7050204@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/29/2014 11:11 AM, Felipe Balbi wrote:
> On Mon, Dec 29, 2014 at 10:51:29AM -0800, Santosh Shilimkar wrote:
>> From: Grygorii Strashko <grygorii.strashko@linaro.org>
>>
>> Sync multi_v7_defconfig with the current keystone_defconfig with
>> recent updates.
>>
>>   CONFIG_PCI_KEYSTONE=y
>>   CONFIG_MTD_NAND_DAVINCI=y
>>   CONFIG_I2C_DAVINCI=y
>>   CONFIG_SPI_DAVINCI=y
>>   CONFIG_GPIO_DAVINCI=y
>>   CONFIG_GPIO_SYSCON=y
>>   CONFIG_POWER_RESET_KEYSTONE=y
>>   CONFIG_DAVINCI_WATCHDOG
>>   CONFIG_USB_DWC3=y
>>   CONFIG_KEYSTONE_USB_PHY=y
>>   CONFIG_TI_AEMIF=y
>>   CONFIG_KEYSTONE_IRQ=y
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
>> Signed-off-by: Santosh Shilimkar <ssantosh@kernel.org>
>
> Reviewed-by: Felipe Balbi <balbi@ti.com>
>
Thanks !!
