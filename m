From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Fri, 04 Jul 2014 20:06:33 +0900
Subject: [PATCHv2 0/5] ARM: remove the sub-node and deprecated
 supports-highspeed property for dwmmc.
In-Reply-To: <CAK5sBcEa5bRKUBB0n422m-K7A7YSshm2kTBUCNPgzwQkws3H8w@mail.gmail.com>
References: <1404128960-27225-1-git-send-email-jh80.chung@samsung.com>
 <CAK5sBcEa5bRKUBB0n422m-K7A7YSshm2kTBUCNPgzwQkws3H8w@mail.gmail.com>
Message-ID: <53B68AB9.9070109@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, All.

Any other comment or review? I hope that these are merged.

Best Regards,
Jaehoon Chung

On 07/01/2014 05:26 PM, Sachin Kamat wrote:
> Hi Jaehoon,
> 
> On Mon, Jun 30, 2014 at 5:19 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Since used the mmc_of_parse(), didn't parse the sub-node.
>> So we can remove the sub-node, because almost SoC used the only one card per a host.
>> And supports-highspeed can be replaced to "cap-mmc/sd-highspeed" property.
>>
>> Jaehoon Chung (5):
>>   mmc: dw_mmc: modify the dt-binding for removing slot-node and
>>     supports-highspeed
>>   ARM: dts: exynos: unuse the slot-node and deprecated the
>>     supports-highspeed for dw-mmc
>>   ARM: dts: socfpga: unuse the slot-node and deprecated the
>>     supports-highspeed for dw-mmc
>>   ARM: dts: rockchip: unuse the slot-node and deprecated the
>>     supports-highspeed for dw-mmc
>>   mmc: dw_mmc: replace "disable-wp" from slot's quirk to host's quirk
> 
> It is a good practice to include revision history for subsequent versions.
> 
> Tested on Exynos 5250 based Snow and Arndale boards. Works fine now.
> 
> Tested-by: Sachin Kamat <sachin.kamat@samsung.com>
> 
