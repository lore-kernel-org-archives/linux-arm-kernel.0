From: scott.branden@broadcom.com (Scott Branden)
Date: Mon, 28 May 2018 12:22:22 -0700
Subject: [PATCH] ARM: dts: cygnus: add ethernet0 alias
In-Reply-To: <CAJiuCcd6Y+H0XJn+7dObiTuhSPXhefrYNh9qDi+=cs8S6-TGgw@mail.gmail.com>
References: <20180503095618.2312-1-peron.clem@gmail.com>
 <74263153-2f69-71e1-513b-e034a505588b@gmail.com>
 <CAJiuCcd6Y+H0XJn+7dObiTuhSPXhefrYNh9qDi+=cs8S6-TGgw@mail.gmail.com>
Message-ID: <699fc4d6-ea98-ddef-8238-630d9271bea8@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18-05-28 01:22 AM, Cl?ment P?ron wrote:
> Could you review it, please.
> Thanks
>
> On Thu, 3 May 2018 at 17:13, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>> +Ray, Scott, Eric, list
>> On 05/03/2018 02:56 AM, Cl?ment P?ron wrote:
>>> In order to avoid Linux generating a random mac address on every boot,
>>> add an ethernet0 alias that will allow u-boot to patch the dtb with
>>> the MAC address.
>>>
>>> Signed-off-by: Cl?ment P?ron <peron.clem@gmail.com>
Acked-by: Scott Branden <scott.branden@broadcom.com>
>>> ---
>>>   arch/arm/boot/dts/bcm-cygnus.dtsi | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi
> b/arch/arm/boot/dts/bcm-cygnus.dtsi
>>> index 9fe4f5a6379e..1a05b8f48b54 100644
>>> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
>>> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
>>> @@ -41,6 +41,10 @@
>>>        model = "Broadcom Cygnus SoC";
>>>        interrupt-parent = <&gic>;
>>>
>>> +     aliases {
>>> +             ethernet0 = &eth0;
>>> +     };
>>> +
>>>        cpus {
>>>                #address-cells = <1>;
>>>                #size-cells = <0>;
>>>
>> --
>> Florian
> Clement
