From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Fri, 7 Oct 2016 16:52:47 +0800
Subject: [PATCH v2 2/2] ARM: dts: rockchip: Add rk3066 MK808 board
In-Reply-To: <18c0552c-10fa-a749-9777-9a99da9f275f@gmail.com>
References: <cover.1475774981.git.paweljarosz3691@gmail.com>
 <b63a0ad452a487beb1d0c07addb9208cc3b3eeef.1475774981.git.paweljarosz3691@gmail.com>
 <a166a444-8819-ffe7-8ee1-1f632f6a66ab@rock-chips.com>
 <18c0552c-10fa-a749-9777-9a99da9f275f@gmail.com>
Message-ID: <202c4ce7-ffaa-33f8-66e4-a48c15fade69@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2016/10/7 16:40, Pawe? Jarosz ??:
> Hi Shawn,
>
>
>>> +&mmc0 {
>>> +    bus-width = <4>;
>>> +    cap-mmc-highspeed;
>>> +    cap-sd-highspeed;
>>> +    mmc-pwrseq = <&mmc_pwrseq>;
>>
>> Removed this could make SD works?
>
> Yes but disabling bus-width causes sd performance decrease(defaults to
> 1?) so i'll leave this one.

I just pointed to the mmc-pwrseq, not for others properties :)

>
> Other sugestions will be included in v3.
>
> Thanks
>
> Pawe?.
>
>
>
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


-- 
Best Regards
Shawn Lin
