From: vz@mleia.com (Vladimir Zapolskiy)
Date: Mon, 21 Dec 2015 18:58:50 +0200
Subject: [PATCH 2/3] arm: dts: phy3250: add SD fixed regulator
In-Reply-To: <5677F3DC.6070402@cogentembedded.com>
References: <1450567932-22994-1-git-send-email-vz@mleia.com>
 <1450567932-22994-3-git-send-email-vz@mleia.com>
 <5677F3DC.6070402@cogentembedded.com>
Message-ID: <56782FCA.2050504@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hell Sergei,

On 21.12.2015 14:43, Sergei Shtylyov wrote:
> Hello.
> 
> On 12/20/2015 2:32 AM, Vladimir Zapolskiy wrote:
> 
>> The change adds fixed voltage regulator for SD controller, ARM MMCI
>> controller driver uses it to control card power management.
>>
>> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
>> ---
>>   arch/arm/boot/dts/phy3250.dts | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/phy3250.dts b/arch/arm/boot/dts/phy3250.dts
>> index 34e15fd..5465b9e 100644
>> --- a/arch/arm/boot/dts/phy3250.dts
>> +++ b/arch/arm/boot/dts/phy3250.dts
>> @@ -45,6 +45,15 @@
>>   			enable-active-high;
>>   			regulator-boot-on;
>>   		};
>> +
>> +		sd_reg: fixed-regulator at 2 {
> 
>     Please just "regulator at 2", to comply with the ePAPR standard.

thanks for review, just for my information, do I understand correctly
that you reference to "Generic Names Recommendation" ?

I have no objection to generalize device tree node name as you
suggested, will do it.

With best wishes,
Vladimir
