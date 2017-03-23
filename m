From: cl@rock-chips.com (=?UTF-8?B?6ZmI5Lqu?=)
Date: Thu, 23 Mar 2017 11:33:28 +0800
Subject: [PATCH v2 4/6] arm64: dts: rockchip: add core dtsi file for
 RK3328 SoCs
In-Reply-To: <14610453.rKm3MBREMz@diego>
References: <1489670244-13328-1-git-send-email-cl@rock-chips.com>
 <1489670244-13328-5-git-send-email-cl@rock-chips.com>
 <14610453.rKm3MBREMz@diego>
Message-ID: <58D34208.6090509@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Heiko

? 2017?03?21? 16:55, Heiko St?bner ??:
> Hi,
>
> Am Donnerstag, 16. M?rz 2017, 21:17:22 CET schrieb cl at rock-chips.com:
>> +		assigned-clock-parents =
>> +			<&cru HDMIPHY>, <&cru PLL_APLL>,
>> +			<&cru PLL_GPLL>, <&xin24m>,
>> +			<&xin24m>, <&xin24m>;
>> +		assigned-clock-rates =
>> +			<0>, <61440000>,
>> +			<0>, <24000000>,
>> +			<24000000>, <24000000>,
>> +			<15000000>, <15000000>,
>> +			<100000000>, <100000000>,
>> +			<100000000>, <100000000>,
>> +			<50000000>, <100000000>,
>> +			<100000000>, <100000000>,
>> +			<50000000>, <50000000>,
>> +			<50000000>, <50000000>,
>> +			<24000000>, <600000000>,
>> +			<491520000>, <1200000000>,
>> +			<150000000>, <75000000>,
>> +			<75000000>, <150000000>,
>> +			<75000000>, <75000000>,
>> +			<300000000>, <100000000>,
>> +			<300000000>, <200000000>,
>> +			<400000000>, <500000000>,
>> +			<200000000>, <300000000>,
>> +			<300000000>, <250000000>,
>> +			<200000000>, <100000000>,
>> +			<24000000>, <100000000>,
>> +			<150000000>, <50000000>,
>> +			<32768>, <32768>;
>> +	};
>> +
>> +	gmac2io: eth at ff540000 {
> phandle should be gmac instead?
> Node name, ethernet at ff540000
RK3328 have another gmac channel with PHY in the soc, so gmac2io mean 
the channel with the PHY outside, and it is also called gmac2io in the TRM.
>
>
> Heiko
>
