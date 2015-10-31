From: salil.mehta@huawei.com (Salil Mehta)
Date: Sat, 31 Oct 2015 02:18:19 +0000
Subject: [PATCH RESEND v2 net-next] net: hisilicon: updates HNS config
 and documents
In-Reply-To: <56341C00.8080303@hisilicon.com>
References: <1445944594-244149-1-git-send-email-huangdaode@hisilicon.com>
 <4549013.K7sn8Pca5b@wuerfel> <56341C00.8080303@hisilicon.com>
Message-ID: <563424EB.1060804@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/31/2015 1:40 AM, huangdaode wrote:
> On 2015/10/30 22:20, Arnd Bergmann wrote:
>> On Tuesday 27 October 2015 19:16:34 huangdaode wrote:
>>>            mdio at 803c0000 {
>>>                      #address-cells = <1>;
>>>                      #size-cells = <0>;
>>> -                   compatible = "hisilicon,mdio","hisilicon,hns-mdio";
>>> +                   compatible = "hisilicon,hns-mdio","hisilicon,mdio";
>>>                      reg = <0x0 0x803c0000 0x0 0x10000>;
>>>
>> Does "hisilicon,mdio" actually have a specific meaning? Is that just 
>> there
>> for legacy reasons?
>>
>>     Arnd
>>
>> .
>>
> hi Arnd,
> "hisilicon,mdio" is  the gernerical configuation compatible  for the 
> default hisilicon chip,
> We use generic hisilicon since our MDIO/PHY is same across flavour of 
> SoCs.
>
Hi Arnd,
Yes, "hisilicon,mdio" exists for the legacy reasons to support older SoC 
Hip04.

Best Regards
Salil
