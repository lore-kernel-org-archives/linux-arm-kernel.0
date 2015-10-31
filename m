From: huangdaode@hisilicon.com (huangdaode)
Date: Sat, 31 Oct 2015 09:40:16 +0800
Subject: [PATCH RESEND v2 net-next] net: hisilicon: updates HNS config
 and documents
In-Reply-To: <4549013.K7sn8Pca5b@wuerfel>
References: <1445944594-244149-1-git-send-email-huangdaode@hisilicon.com>
 <4549013.K7sn8Pca5b@wuerfel>
Message-ID: <56341C00.8080303@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/10/30 22:20, Arnd Bergmann wrote:
> On Tuesday 27 October 2015 19:16:34 huangdaode wrote:
>>            mdio at 803c0000 {
>>                      #address-cells = <1>;
>>                      #size-cells = <0>;
>> -                   compatible = "hisilicon,mdio","hisilicon,hns-mdio";
>> +                   compatible = "hisilicon,hns-mdio","hisilicon,mdio";
>>                      reg = <0x0 0x803c0000 0x0 0x10000>;
>>   
>>
> Does "hisilicon,mdio" actually have a specific meaning? Is that just there
> for legacy reasons?
>
> 	Arnd
>
> .
>
hi Arnd,
"hisilicon,mdio" is  the gernerical configuation compatible  for the 
default hisilicon chip,
We use generic hisilicon since our MDIO/PHY is same across flavour of SoCs.

-- 
Best Regards
Daode Huang
