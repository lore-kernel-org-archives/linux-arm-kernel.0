From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 14 Mar 2016 16:22:30 +0900
Subject: [PATCH 05/10] ARM: dts: Add exynos3250-artik5 dtsi file for ARTIK5
 module
In-Reply-To: <56E660F1.3060407@samsung.com>
References: <1457921056-21257-1-git-send-email-cw00.choi@samsung.com>
 <1457921056-21257-6-git-send-email-cw00.choi@samsung.com>
 <56E65D5D.8060702@samsung.com> <56E660F1.3060407@samsung.com>
Message-ID: <56E666B6.7060701@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016? 03? 14? 15:57, Chanwoo Choi wrote:
> Hi Krzysztof,
> 
> On 2016? 03? 14? 15:42, Krzysztof Kozlowski wrote:
>> On 14.03.2016 11:04, Chanwoo Choi wrote:
>>> This patch adds the support for Device Tree source for Samsung ARTIK5 module[1]
>>> based on Exynos3250 SoC. The ARTIK5 module includes the follwoing devices:
>>> - Application Processor (Samsung Exynos3250)
>>> - WiFi/BT Combo chip (Broadcom4354)
>>> - PMIC (Samsung S2MPS14)
>>> - eMMC (4GB)
>>> - DRAM LPDDR3 (512MB)
>>> - Connectors pin (60 Pins x 3 set)
>>>
>>> Also, this patch adds the ARTIK5 development board[2] dts file which includes
>>> the ARTIK5 module[1] and have the devices such as sound codec, sd card port,
>>> ethernet port, uart port and so on.
>>>
>>> [1] https://www.artik.io/hardware/artik-5
>>> [2] http://www.digikey.com/product-search/en?FV=ffecca14
>>>
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
>>> ---
>>>  arch/arm/boot/dts/Makefile                    |   1 +
>>>  arch/arm/boot/dts/exynos3250-artik5-devel.dts |  26 +++
>>>  arch/arm/boot/dts/exynos3250-artik5.dtsi      | 282 ++++++++++++++++++++++++++
>>
>> Plus changes in
>> Documentation/devicetree/bindings/arm/samsung/samsung-boards.txt.

OK.
Also, I'll change the board name from 'artik5-devel' to 'artik5-eval'.

[snip]

Best Regards,
Chanwoo Choi
