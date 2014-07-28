From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Mon, 28 Jul 2014 22:02:32 +0800
Subject: [GIT PULL][for 3.17] pull request for hisilicon soc
In-Reply-To: <20140728130526.GM23220@titan.lakedaemon.net>
References: <53D1F2B0.1020603@hisilicon.com> <19341047.6Jx15lyPBg@wuerfel>
 <CAD6h2NRaR+JoAsQt_0uwP5hacqKzFnTUbqToGj6JfEyACoZc+A@mail.gmail.com>
 <5326154.xHtqUP4l2C@wuerfel>
 <20140728130526.GM23220@titan.lakedaemon.net>
Message-ID: <CAD6h2NQOGy0BeLHjQ4jv-kN74B-DHz5jCwXyo6rgs=WM1rXMiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 July 2014 21:05, Jason Cooper <jason@lakedaemon.net> wrote:
> Arnd, Marc,
>
>
> I'd like Marc to review the newest version of the changes to the GIC and
> Ack before I'll pull them in.  He was on vacation up until today.
> You'll be able to pull in a tag on irqchip/gic and base off of that if
> needed.
>
> Conversely, if you were to move the HiP04 to a separate file, like I
> asked, (using Mark's suggestion of function pointers, which you've
> done), I could probably Ack it to go through arm-soc.  There are simply
> too many changes to irq-gic.c this time around...
>
> thx,
>
> Jason.

Only the 1/11 (irq patch) is based on your git tree because of GICv3.
If you could merge it into your git tree, it would be great.

Best Regards
Haojian
