From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 11 Jun 2017 23:52:28 +0200
Subject: [PATCH v2 01/11] pinctrl: dt-bindings: add documentation for
 AP806 pin controllers
In-Reply-To: <878tl1pot6.fsf@free-electrons.com>
References: <cover.8fe5f7c62a787452878ca071fa00b953e96988ef.1496413293.git-series.gregory.clement@free-electrons.com>
 <2d89fbc10d07c890336eabbd362e55cb2e5055b5.1496413293.git-series.gregory.clement@free-electrons.com>
 <CACRpkdYw3AgKBa+y-U9=1d9HqYyPGYK1y_5eBYoobV6s=4T0Wg@mail.gmail.com>
 <878tl1pot6.fsf@free-electrons.com>
Message-ID: <CACRpkdauBvun9COkL2Qox2k0vyOyWbRti=QmZPNE2DnwWCiJoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 9, 2017 at 10:07 AM, Gregory CLEMENT
<gregory.clement@free-electrons.com> wrote:

> As I wrote in the cover letter :
> "The patch modifying the documentation still depend on the ones of the
> clk series. For the ap806 a first stable branch is already available:
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/log/?h=clk-ap806"

Sorry I may miss things like that... usually it is better if patches
that depend on each other for merging are in the same series.

> In the previous version of the series the clk maintainer said they will
> provide stable branch for the documentation. For ap806 it is already
> done, but not yet for cp110. But if you still have problem with it Rob
> offer to take care of the devie tree documentation.
>
> Just let us know what you prefer.

I don't understand. Tell me what I need to do or we can just wait
a kernel cycle before merging this I guess.

Either I need an immutable branch or I merge the clock patches
I guess. Neither is very good but I'm open to compromises.

>> I hope for the love of god that this does not also clash with the
>> PWM stuff that is patching around in the GPIO tree, if it does
>> I might very well throw up my hands and defer merging all of
>> this until the next kernel cycle past v4.13-rc1.
>
> To avoid this kind of issues the series are based on next-20170531 in
> order to have in the same time the devel branch of the linux-gpio tree
> and the devel branch of the linux-pinctrl tree.

I see. Well if nothing else works, we just defer.

> I use the linux-next tree because you already picked up some patches of
> my first series and applied it on your devel branches. If I rebased on
> v4;12-rc2, obviously it won't work. So really basing the series on your
> devel branch is the best thing to do.

Indeed, sorry, the left hand doesn't know what the right hand is
doing sometimes.

> I saw that you already applied the PWM patch so as soon as they were
> visible on the devel branches I will rebased the series on it and submit
> it a new version.

OK

Yours,
Linus Walleij
