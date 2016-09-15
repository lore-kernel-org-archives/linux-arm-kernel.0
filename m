From: xuwei5@hisilicon.com (Wei Xu)
Date: Thu, 15 Sep 2016 09:51:51 +0100
Subject: [GIT PULL] arm64: dts: hisilicon dts updates for v4.9
In-Reply-To: <4112756.vQdZALs121@wuerfel>
References: <57C95594.40105@hisilicon.com> <4112756.vQdZALs121@wuerfel>
Message-ID: <57DA6127.8050707@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 14/09/2016 16:06, Arnd Bergmann wrote:
> On Friday, September 2, 2016 11:33:56 AM CEST Wei Xu wrote:
>> ARM64: DT: Hisilicon SoC DT updates for 4.9
>>
>> - Set UART1 clock frequency to 150MHz for higher baud rates on hikey
>> - Add display subsystem, HDMI and cma nodes on hikey to support display
>> - Add syscon-reboot-mode support on hikey
>> - Add pstore support on hikey
>> - Add resets and sd-uhs-sdr property dwmmc ndoe on hikey
>> - Remove hip05_hns.dtsi since it can not be built without mbigenv1
>> - Update system controller bingding document for hip05 and hip06
>> - Add xge and sas support on hip06
>>
> 
> Pulled into next/dt64, thanks!

Thanks!

Best Regards,
Wei

> 
> 	Arnd
> 
> 
> .
> 
