From: xuwei5@hisilicon.com (Wei Xu)
Date: Mon, 19 Jun 2017 09:33:49 +0100
Subject: [GIT PULL v2] arm64: dts: hisilicon dts updates for v4.13
In-Reply-To: <20170619035739.GC30022@localhost>
References: <5942EA83.6040907@hisilicon.com> <5943F06D.7000305@hisilicon.com>
 <20170619035739.GC30022@localhost>
Message-ID: <59478C6D.6070702@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 2017/6/19 4:57, Olof Johansson wrote:
> On Fri, Jun 16, 2017 at 03:51:25PM +0100, Wei Xu wrote:
>> Hi Arnd, Hi Olof, Hi Kevin,
>>
>> Please help to pull the following changes.
>> Thanks!
>>
>> And the patch "arm64: dts: hi6220: Add k3-dma and i2s/hdmi audio support"
>> depends on audio-graph-card that will be landed on 4.13.
>> But the dts part is checked without any warning and can be compiled.
>>
>> Best Regards,
>> Wei
>>
>> ---
>>
>> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
>>
>>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
>>
>> are available in the git repository at:
>>
>>   git://github.com/hisilicon/linux-hisi.git tags/hisi-arm64-dt-for-4.13-v2
>>
>> for you to fetch changes up to 0cf6a8e2fb8413b581fc0d960f7831b0e7583406:
>>
>>   arm64: dts: hi6220: Add k3-dma and i2s/hdmi audio support (2017-06-16 15:31:21 +0100)
>>
>> ----------------------------------------------------------------
>> ARM64: DT: Hisilicon SoC DT updates for 4.13
>>
>> - Add and update Hi3660-Hikey960 board, Hi3660 PCIe RC, Hi6421v530 MFD and
>>   Hi3660 MMC binding
>> - Add and refine devices support for Hi3660-Hikey 960 including clock, reset,
>>   I2C, GPIO, UART, Bluetooth, RTC, Power Key, LED, SPI, timer, PMIC, regulator,
>>   sd/sdio and WiFi
>> - Add k3-dma and i2s/hdmi audio support based on audio-card-graph method for
>>   Hikey board
> 
> Merged, thanks!

Thanks!

Best Regards,
Wei

> 
> 
> -Olof
> 
> _______________________________________________
> linuxarm mailing list
> linuxarm at huawei.com
> http://rnd-openeuler.huawei.com/mailman/listinfo/linuxarm
> 
> .
> 
