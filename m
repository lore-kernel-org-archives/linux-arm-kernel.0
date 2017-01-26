From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 26 Jan 2017 19:23:25 +0800
Subject: [PATCH 10/11] arm64: dts: allwinner: Remove no longer used
 pinctrl/sun4i-a10.h header
In-Reply-To: <20170126101529.j3fuku4hyy3pbge3@lukather>
References: <20170124023230.3990-1-wens@csie.org>
 <20170124023230.3990-11-wens@csie.org>
 <20170126101529.j3fuku4hyy3pbge3@lukather>
Message-ID: <CAGb2v66cQoPQzd6W1D8bZ5hSURfGP3icJjeoo1mNk2ccG9B2vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 6:15 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Jan 24, 2017 at 10:32:29AM +0800, Chen-Yu Tsai wrote:
>> All dts files for the sunxi platform have been switched to the generic
>> pinconf bindings. As a result, the sunxi specific pinctrl macros are
>> no longer used.
>>
>> Remove the #include entry with the following command:
>>
>>     sed -i -e '/pinctrl\/sun4i-a10.h/D' \
>>       arch/arm64/boot/dts/allwinner/*.dts?
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>
> Applied, thanks!
>
> Maybe we should also remove the header entirely?

I don't know. What do we do about deprecated bindings?

ChenYu
