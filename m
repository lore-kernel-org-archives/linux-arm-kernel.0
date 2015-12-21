From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 21 Dec 2015 20:04:03 +0300
Subject: [PATCH 2/3] arm: dts: phy3250: add SD fixed regulator
In-Reply-To: <56782FCA.2050504@mleia.com>
References: <1450567932-22994-1-git-send-email-vz@mleia.com>
 <1450567932-22994-3-git-send-email-vz@mleia.com>
 <5677F3DC.6070402@cogentembedded.com> <56782FCA.2050504@mleia.com>
Message-ID: <56783103.3070008@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/21/2015 07:58 PM, Vladimir Zapolskiy wrote:

>>> The change adds fixed voltage regulator for SD controller, ARM MMCI
>>> controller driver uses it to control card power management.
>>>
>>> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
>>> ---
>>>    arch/arm/boot/dts/phy3250.dts | 10 ++++++++++
>>>    1 file changed, 10 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/phy3250.dts b/arch/arm/boot/dts/phy3250.dts
>>> index 34e15fd..5465b9e 100644
>>> --- a/arch/arm/boot/dts/phy3250.dts
>>> +++ b/arch/arm/boot/dts/phy3250.dts
>>> @@ -45,6 +45,15 @@
>>>    			enable-active-high;
>>>    			regulator-boot-on;
>>>    		};
>>> +
>>> +		sd_reg: fixed-regulator at 2 {
>>
>>      Please just "regulator at 2", to comply with the ePAPR standard.
>
> thanks for review, just for my information, do I understand correctly
> that you reference to "Generic Names Recommendation" ?

    Sure, AKA 2.2.2. :-)

> I have no objection to generalize device tree node name as you
> suggested, will do it.

    TIA.

> With best wishes,
> Vladimir

MBR, Sergei
