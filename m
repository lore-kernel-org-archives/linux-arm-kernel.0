From: hskinnemoen@gmail.com (=?UTF-8?Q?H=C3=A5vard_Skinnemoen?=)
Date: Thu, 23 Feb 2017 21:18:13 -0800
Subject: [PATCH v2 1/3] mtd: nand: Cleanup/rework the atmel_nand driver
In-Reply-To: <20170221171438.e5hvruoixafpcdps@piout.net>
References: <CAHp75Vc_q-bEzA2-hVpHyR0GZ8mXxwJ8-UjECe31T04mb67q4w@mail.gmail.com>
 <20170221090610.6d531b94@bbrezillon>
 <CAHp75VfZfj-8ih3vg63w_dAq8xXE2Whu1bANXRcXS1_EGNq43A@mail.gmail.com>
 <20170221112641.6276c001@bbrezillon>
 <CAHp75Vcb9gtzF7LvH74JwL4dTUyQvKmg=dnTXKfjhVHuyK3WXg@mail.gmail.com>
 <20170221112720.ynehsryprhrhzjla@piout.net>
 <CAHp75VcKjYYAw8gw8yYXrd-vzZo50WOQ06AzPx+0g9Zakzjm-w@mail.gmail.com>
 <20170221162133.jch6yzpotj4s7zob@piout.net>
 <CAHp75VeB4eVuN5NMfAfQUtssuHezTyAM8FUswuR8FheUk1V-oA@mail.gmail.com>
 <CAHp75Vc54+GR99qM8vUDfQnehFx0g5q137k-w5XY3023UZyr5w@mail.gmail.com>
 <20170221171438.e5hvruoixafpcdps@piout.net>
Message-ID: <CACiLriSdRM4ZfoDsxFhf6ZVwAtacJOJ28M8CvOg6kC_XN0T-Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2017 at 9:14 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 21/02/2017 at 18:43:35 +0200, Andy Shevchenko wrote:
>> >> Come on, v4.10 has just been release and
>>
>> It doesn't build anymore. And current case even worse
>> Face it. It's dead.
>>
>
> I agree it hasn't seen any significant development in a while but I'm
> not the on able to take that decision.

I've been wanting to add devicetree support for some time, but I no
longer remember how to build the toolchain, and I don't have fond
memories of that whole process. And the fact that
4.2.4-atmel.1.1.3.avr32linux.1 is still the most current version of
gcc doesn't make me very optimistic.

So while Hans-Christian and others have been doing a great job of
keeping AVR32 on life support, I tend to think that if there's not
enough enthusiasm for the architecture to build a modern toolchain or
add support for device tree, avr32-linux probably isn't going anywhere
exciting.

> A few weeks ago, I was telling Boris to let it not build for a while and
> then remove it. You already went out of your way to make it work. Again,
> feel free to send a patch removing avr32. I can only see a lot of
> benefits for the Atmel ARM SoCs and the many cleanups that will follow.

Agree, I can't help but feel that the AVR32 support is doing more harm
than good at this point.

> If nobody complains about the 4.10 breakage, You'll have plenty of time
> to remove it for 4.12

I'm fine with that, but I haven't put much effort into keeping it
alive lately. If Hans-Christian agrees, I'm willing to post a patch to
remove it, or ack someone else's patch.

H?vard
