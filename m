From: boojin.kim@samsung.com (Boojin Kim)
Date: Tue, 03 Apr 2012 17:07:21 +0900
Subject: [PATCH 0/4] memcpy optimized with strd/ldrd
In-Reply-To: <alpine.LFD.2.02.1203300914510.24151@xanadu.home>
References: <03e101cd0e07$eec39f10$cc4add30$@com>
 <030501cd0e6a$03642770$0a2c7650$%kim@samsung.com>
 <alpine.LFD.2.02.1203300914510.24151@xanadu.home>
Message-ID: <008f01cd1170$cbee3dd0$63cab970$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre wrote:

> > >
> > > Here's my version.  Lightly tested.
> > > I have no A15 hardware to run any performance comparison though.
> > >
> > I'm reviewing and testing your patch. But, My other work disturbs to reviewing it.
> > I will give you feedback soon within this week.
> > Wait a little more.
> > And, Thanks for your patches. :)
>
> FYI, it occurred to me that some corner cases might not be quite right
> with regards to alignment for the STRD instruction.  It seems that the
> hardware on which I tested it (Marvell Dove CPU) apparently copes with
> misaligned SDRD's when they're still 32-bit aligned.  So I need to run
> this code through a real validation harness on different hardware.

It's sad, but the performance result wasn't better after adapting your patch.
I think something on 1~3 patch brings performance degreasing.
Thanks :)

>
>
> Nicolas
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
