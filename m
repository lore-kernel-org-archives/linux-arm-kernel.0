From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 9 Sep 2013 09:45:25 +0200
Subject: [PATCH 01/04] ARM: shmobile: Initial r8a7791 SoC support
In-Reply-To: <CANqRtoQzLKk3EKcm=EiZCg73fgDBZ1xjPi_6fH_PsGdkr6w5sA@mail.gmail.com>
References: <20130904034525.12546.24775.sendpatchset@w520>
 <20130904034557.12546.97503.sendpatchset@w520>
 <CACRpkdb7QkqCmTMua1yJNJxSAWff=0f6a2SWkf6K9SqbW0BOVg@mail.gmail.com>
 <CANqRtoQzLKk3EKcm=EiZCg73fgDBZ1xjPi_6fH_PsGdkr6w5sA@mail.gmail.com>
Message-ID: <CACRpkdZGLR3=UZ7f-9r02Gea2hTomp+6+bz0BDQOvk9zRHTxxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 9, 2013 at 9:21 AM, Magnus Damm <magnus.damm@gmail.com> wrote:

> Fortunately there are plans to convert several mach-shmobile SoCs to
> common clocks over the next 6 months. As you know, we spent much time
> and efforts converting to pinctrl last two 6 month periods, and now we
> will be targeting common clocks.

I trust you on this, it's not for me to decide but for the ARM SoC
maintainers. I think Arnd basically said at one point that it is OK
to add some new cruft as long as you remove more old cruft at
the same time, so I guess you will have to make an argument that
this is happening.

> There are several incremental patches available for r8a7791, but since
> this is a new and rare platform it won't be the first SoC we convert
> to common clocks. So CCF development will happen on r8a7791, but it
> won't be the first platform.

This is pretty much the inverse argument of the usual stance of
the ARM SoC tree - usually we ask that new platforms should use
new frameworks. I do understand it from a practical point of view,
that new SoCs only exist in few prototypes.

But again, this is up for the ARM SoC folks to decide.

Yours,
Linus Walleij
