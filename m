From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 28 Feb 2017 23:50:14 +0800
Subject: [linux-sunxi] Re: [RFC PATCH 4/9] clk: sunxi-ng: support R40 SoC
In-Reply-To: <20170224002028.miupa6dzefgxbfse@lukather>
References: <20170222231738.HXRSmi86@smtp1o.mail.yandex.net>
 <20170224002028.miupa6dzefgxbfse@lukather>
Message-ID: <CAGb2v66AZK+g3xX4cXd8Q6Ob_+SxpYsxHBEfC9Ec2QsdN4eA9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Icenowy,

On Fri, Feb 24, 2017 at 8:20 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Wed, Feb 22, 2017 at 01:54:58PM +0800, Icenowy Zheng wrote:
>>
>> 2017?2?22? 07:03? Maxime Ripard <maxime.ripard@free-electrons.com>???
>> >
>> > Hi,
>> >
>> > On Sat, Feb 18, 2017 at 01:37:17AM +0800, Icenowy Zheng wrote:
>> > > Allwinner R40 SoC have a clock controller module in the style of the
>> > > SoCs beyond sun6i, however, it's more rich and complex.
>> > >
>> > > Add support for it.
>> > >
>> > > As the user manual is still not available, this driver is made with
>> > > knowledge from clk-sun8iw11.c in the BSP kernel source.
>> >
>> > Missing SoB.
>> >
>> > Why are some patches tagged as RFC and some don't?
>>
>> There's still no open User Manual for R40, so I tagged CCU-related
>> drivers RFC.
>>
>> Pinctrl driver can be written with the datasheet draft, which is
>> available now.
>>
>> For USB we have never user manual so everything is educated guess --
>> so it's not RFC.
>
> It's still kind of weird to mix and match patches with and without RFC
> tags.

Allwinner just released the docs today. See

    https://github.com/tinalinux/docs/tree/r40-v1.y

Could you check your patches against it, and maybe we don't need the
RFC tags anymore?

ChenYu
