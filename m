From: yankejian@huawei.com (Yankejian (Hackim Yim))
Date: Mon, 7 Dec 2015 09:30:56 +0800
Subject: [PATCH RESEND net-next 2/3] dts: hisi: fixes no syscon error when
 init mdio
In-Reply-To: <5330584.WSWh7F8G32@wuerfel>
References: <1449302218-54374-1-git-send-email-yankejian@huawei.com>
 <1449302218-54374-3-git-send-email-yankejian@huawei.com>
 <5330584.WSWh7F8G32@wuerfel>
Message-ID: <5664E150.4020402@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/12/6 6:15, Arnd Bergmann wrote:
> On Saturday 05 December 2015 15:56:57 yankejian wrote:
>>                 #size-cells = <0>;
>>                 compatible = "hisilicon,hns-mdio";
>> -               reg = <0x0 0x803c0000 0x0 0x10000
>> -                      0x0 0x80000000 0x0 0x10000>;
>> +               reg = <0x0 0x803c0000 0x0 0x10000>;
>> +               subctrl_vbase = <&peri_c_subctrl>;
>>  
>>                 soc0_phy0: ethernet-phy at 0 {
>>                         reg = <0x0>;
> I don't see the subctrl_vbase property documented in the binding. Please
> modify the binding as well.
>
> Also, please use the normal naming conventions using '-' instead of '_'
> inside of property names.
>
> 	Arnd
>
> .

Hi, Arnd
Thanks for your suggestions. i will fixes it later.
