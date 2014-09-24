From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 24 Sep 2014 09:18:16 +0200
Subject: [linux-sunxi] Re: [PATCH 3/6] ARM: dts: sunxi: Add Allwinner
 A80 dtsi
In-Reply-To: <CAGb2v64voZpK_82wtkErRowR0vjEUALNUwvCx_sd8Q5wb4Hq-g@mail.gmail.com>
References: <1411311493-24344-1-git-send-email-wens@csie.org>
 <1411311493-24344-4-git-send-email-wens@csie.org>
 <20140924063738.GQ15315@lukather>
 <CAGb2v64voZpK_82wtkErRowR0vjEUALNUwvCx_sd8Q5wb4Hq-g@mail.gmail.com>
Message-ID: <54227038.2020805@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,


>>> +
>>> +     memory {
>>> +             reg = <0x20000000 0x40000000>;
>>
>> Usually, what we put there was the maximum amount of RAM that can be
>> handled by the SoC. I think that it can go above 1GB
> 
> With LPAE, it can handle 8GB. But the DT won't take 64bit values.
> I'm not sure how to get it in. I'll look around for examples.

You can have a look on what we did for Armada XP:

arch/arm/boot/dts/armada-370-xp.dtsi
arch/arm/boot/dts/armada-xp.dtsi
arch/arm/boot/dts/armada-xp-gp.dts

I created a skeleton64.dtsi for this case

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
