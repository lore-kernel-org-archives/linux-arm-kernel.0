From: paweljarosz3691@gmail.com (=?UTF-8?Q?Pawe=c5=82_Jarosz?=)
Date: Fri, 7 Oct 2016 10:40:21 +0200
Subject: [PATCH v2 2/2] ARM: dts: rockchip: Add rk3066 MK808 board
In-Reply-To: <a166a444-8819-ffe7-8ee1-1f632f6a66ab@rock-chips.com>
References: <cover.1475774981.git.paweljarosz3691@gmail.com>
 <b63a0ad452a487beb1d0c07addb9208cc3b3eeef.1475774981.git.paweljarosz3691@gmail.com>
 <a166a444-8819-ffe7-8ee1-1f632f6a66ab@rock-chips.com>
Message-ID: <18c0552c-10fa-a749-9777-9a99da9f275f@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,


>> +&mmc0 {
>> +    bus-width = <4>;
>> +    cap-mmc-highspeed;
>> +    cap-sd-highspeed;
>> +    mmc-pwrseq = <&mmc_pwrseq>;
>
> Removed this could make SD works?

Yes but disabling bus-width causes sd performance decrease(defaults to 
1?) so i'll leave this one.

Other sugestions will be included in v3.

Thanks

Pawe?.
