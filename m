From: codekipper@gmail.com (Code Kipper)
Date: Mon, 24 Jul 2017 11:06:35 +0200
Subject: [linux-sunxi][PATCH] ARM: dts: sun7i: Add I2S0 pinctrl settings
In-Reply-To: <20170724082022.wpeqrxjayqnpiw2p@flea>
References: <20170722064313.7535-1-codekipper@gmail.com>
 <20170724082022.wpeqrxjayqnpiw2p@flea>
Message-ID: <CAEKpxBn57hRC8zcGkizd286W0WMif2w4ay2VqN812jUnbhwxLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No...I've only got an Olimex SOM EVB which exposes these pins on a
GPIO header (like many of the dev boards). Just thought if we included
them in the dtsi then adding overlays for i2s devices would be
simplified.
BR,
CK

On 24 July 2017 at 10:20, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Marcus,
>
> On Sat, Jul 22, 2017 at 08:43:13AM +0200, codekipper at gmail.com wrote:
>> From: Marcus Cooper <codekipper@gmail.com>
>>
>> The A20 SoC has a couple of i2s blocks. This patch adds
>> the pinctrl settings for block i2s0.
>>
>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>
> We're not adding pin groups that are not used by anyone. If you have a
> board using them, please send the DT for that board too.
>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
