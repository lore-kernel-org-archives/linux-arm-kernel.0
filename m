From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 9 Sep 2013 17:05:18 +0900
Subject: [PATCH 01/04] ARM: shmobile: Initial r8a7791 SoC support
In-Reply-To: <CACRpkdZGLR3=UZ7f-9r02Gea2hTomp+6+bz0BDQOvk9zRHTxxw@mail.gmail.com>
References: <20130904034525.12546.24775.sendpatchset@w520>
 <20130904034557.12546.97503.sendpatchset@w520>
 <CACRpkdb7QkqCmTMua1yJNJxSAWff=0f6a2SWkf6K9SqbW0BOVg@mail.gmail.com>
 <CANqRtoQzLKk3EKcm=EiZCg73fgDBZ1xjPi_6fH_PsGdkr6w5sA@mail.gmail.com>
 <CACRpkdZGLR3=UZ7f-9r02Gea2hTomp+6+bz0BDQOvk9zRHTxxw@mail.gmail.com>
Message-ID: <CANqRtoQ0dnG6HwjJSrK8+Qt8wvJhqsJHxgj-LGvnJvS0KT81nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 9, 2013 at 4:45 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Sep 9, 2013 at 9:21 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>
>> Fortunately there are plans to convert several mach-shmobile SoCs to
>> common clocks over the next 6 months. As you know, we spent much time
>> and efforts converting to pinctrl last two 6 month periods, and now we
>> will be targeting common clocks.
>
> I trust you on this, it's not for me to decide but for the ARM SoC
> maintainers. I think Arnd basically said at one point that it is OK
> to add some new cruft as long as you remove more old cruft at
> the same time, so I guess you will have to make an argument that
> this is happening.

Yeah, I agree. I hope to discuss this in person later this Autumn.

>> There are several incremental patches available for r8a7791, but since
>> this is a new and rare platform it won't be the first SoC we convert
>> to common clocks. So CCF development will happen on r8a7791, but it
>> won't be the first platform.
>
> This is pretty much the inverse argument of the usual stance of
> the ARM SoC tree - usually we ask that new platforms should use
> new frameworks. I do understand it from a practical point of view,
> that new SoCs only exist in few prototypes.

I suppose negotiation has to happen on some level, and I appreciate
the higher level give-and-take approach that Arnd has been taking. At
this time though, apart from common clocks, extended DT support and
multiplatform I'm not so sure what desired cleanup-wise.

> But again, this is up for the ARM SoC folks to decide.

Yep. Thanks for your comments!

/ magnus
