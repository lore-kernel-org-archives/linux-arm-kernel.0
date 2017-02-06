From: eddie.cai.linux@gmail.com (Eddie Cai)
Date: Mon, 6 Feb 2017 13:52:01 +0800
Subject: [PATCH V2 2/2] ARM: dts: rockchip: add dts for RK3288-Tinker board
In-Reply-To: <20170206025435.GA32506@lunn.ch>
References: <1486347287-31051-1-git-send-email-eddie.cai@rock-chips.com>
 <1486347287-31051-3-git-send-email-eddie.cai@rock-chips.com>
 <20170206025435.GA32506@lunn.ch>
Message-ID: <CAJrj+DPVw9uZ9VS_mS4U9t8rSKxoQJSzbQK=DgtuVecOoX3u8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew

2017-02-06 10:54 GMT+08:00 Andrew Lunn <andrew@lunn.ch>:
> Hi Eddie
>
>> +             button at 0 {
>> +                     gpios = <&gpio0 5 GPIO_ACTIVE_LOW>;
>> +                     linux,code = <116>;
>
> It is a good idea to use include/dt-bindings/input/input.h
>
> and then you can replace <116> with < KEY_POWER > which is more
> readable.
Thanks, I will modify it in next version.
>
>> +                     label = "GPIO Key Power";
>> +                     linux,input-type = <1>;
>
> < EV_KEY >
>
>> +                     gpio-key,wakeup = <1>;
>
> This has been replace with wakeup-source.
Thanks, I will modify it in next version
>
>> +                     debounce-interval = <100>;
>> +             };
>> +     };
>
>   Andrew
