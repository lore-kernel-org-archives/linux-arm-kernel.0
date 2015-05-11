From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Mon, 11 May 2015 14:23:54 +0530
Subject: [PATCH 3/6] clk: sunxi: Add A33 clock for compilation
In-Reply-To: <20150510101750.GC11057@lukather>
References: <1431240383-12763-1-git-send-email-vishnupatekar0510@gmail.com>
 <1431240383-12763-4-git-send-email-vishnupatekar0510@gmail.com>
 <20150510101750.GC11057@lukather>
Message-ID: <CAEzqOZv5pDPJgBfvNKk7vZuTr5H9hLdEOweyxStRFtarNxtFhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, May 10, 2015 at 3:47 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Sun, May 10, 2015 at 12:16:20PM +0530, Vishnu Patekar wrote:
>> A33 clock control unit is similar to A23.
>>
>> A33 specific clocks are not yet implemented, added CLK_OF_DECLARE
>> to get it compiled for A33.
>
> That commit log doesn't make any sense.
>
> What you're doing isn't about whether or not that will be compiled,
> but whether you're registering the clocks and which clocks you
> protect.
Actually, It's just registering the a33 clocks and reusing a23 code.
nothing to do with compile. I'll correct it in next patch version.
>
>> Signed-off-by: VishnuPatekar <vishnupatekar0510@gmail.com>
>
> Isn't it supposed to have a space in the middle of your name, just
> like you have in your mail address?
Yes, There should be space.
>
> Thanks,
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
