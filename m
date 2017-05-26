From: eddie.cai.linux@gmail.com (Eddie Cai)
Date: Fri, 26 May 2017 15:03:05 +0800
Subject: [PATCH V2] ARM: dts: rockchip:remove hs200 support for firefly
 reload
In-Reply-To: <354b634b-0ba6-682e-95fa-52b32e3cc94c@rock-chips.com>
References: <1495616267-5305-1-git-send-email-eddie.cai.linux@gmail.com>
 <354b634b-0ba6-682e-95fa-52b32e3cc94c@rock-chips.com>
Message-ID: <CAJrj+DN+TcXGHp5HScLJrka9ESHh=8677VtU7g8fQaLPMBxe_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-05-26 14:49 GMT+08:00 Shawn Lin <shawn.lin@rock-chips.com>:
> Hi Eddie,
>
> ? 2017/5/24 16:57, Eddie Cai ??:
>>
>> due to layout limitation. not all of the reload board can support hs200.
>> so remove hs200 support to make all board can boot up.
>>
>> Signed-off-by: Eddie Cai <eddie.cai.linux@gmail.com>
>> ---
>>  arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
>> b/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
>> index 4cfa109..56ac1e6f 100644
>> --- a/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
>> +++ b/arch/arm/boot/dts/rk3288-firefly-reload-core.dtsi
>> @@ -75,8 +75,6 @@
>>         bus-width = <8>;
>>         cap-mmc-highspeed;
>>         disable-wp;
>> -       mmc-hs200-1_8v;
>
>
> On which tree were you basing? I can't git-am this one for today's
> linux-next?
It based on torvalds's tree
>
>
>>         non-removable;
>>         num-slots = <1>;
>>         pinctrl-names = "default";
>>
>
