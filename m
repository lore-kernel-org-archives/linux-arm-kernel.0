From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 09 Jun 2017 10:07:01 +0200
Subject: [PATCH v2 01/11] pinctrl: dt-bindings: add documentation for
 AP806 pin controllers
In-Reply-To: <CACRpkdYw3AgKBa+y-U9=1d9HqYyPGYK1y_5eBYoobV6s=4T0Wg@mail.gmail.com>
 (Linus Walleij's message of "Fri, 9 Jun 2017 09:50:20 +0200")
References: <cover.8fe5f7c62a787452878ca071fa00b953e96988ef.1496413293.git-series.gregory.clement@free-electrons.com>
 <2d89fbc10d07c890336eabbd362e55cb2e5055b5.1496413293.git-series.gregory.clement@free-electrons.com>
 <CACRpkdYw3AgKBa+y-U9=1d9HqYyPGYK1y_5eBYoobV6s=4T0Wg@mail.gmail.com>
Message-ID: <878tl1pot6.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,
 
 On ven., juin 09 2017, Linus Walleij <linus.walleij@linaro.org> wrote:

> On Fri, Jun 2, 2017 at 4:23 PM, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
>
>> Document the device tree binding for the pin controllers found on the
>> Armada 7K and Armada 8K SoCs.
>>
>> Acked-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>
> This patch does not apply to any of my branches, I have no clue
> what tree you're basing this on.
>
> I would prefer a series based on a pure v4.12-rc2 I think, as this
> is what both the pin control and GPIO development branches
> is based on, unless you have a better merge strategy to suggest?

As I wrote in the cover letter :
"The patch modifying the documentation still depend on the ones of the
clk series. For the ap806 a first stable branch is already available:
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/log/?h=clk-ap806"

In the previous version of the series the clk maintainer said they will
provide stable branch for the documentation. For ap806 it is already
done, but not yet for cp110. But if you still have problem with it Rob
offer to take care of the devie tree documentation.

Just let us know what you prefer.

>
> I hope for the love of god that this does not also clash with the
> PWM stuff that is patching around in the GPIO tree, if it does
> I might very well throw up my hands and defer merging all of
> this until the next kernel cycle past v4.13-rc1.

To avoid this kind of issues the series are based on next-20170531 in
order to have in the same time the devel branch of the linux-gpio tree
and the devel branch of the linux-pinctrl tree.


>
> Please rebase on v4.12-rc2 and resend.

I use the linux-next tree because you already picked up some patches of
my first series and applied it on your devel branches. If I rebased on
v4;12-rc2, obviously it won't work. So really basing the series on your
devel branch is the best thing to do.

I saw that you already applied the PWM patch so as soon as they were
visible on the devel branches I will rebased the series on it and submit
it a new version.

Thanks,

Gregory

>
> Yours,
> Linus Walleij

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
