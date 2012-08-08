From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 8 Aug 2012 13:55:30 +0200
Subject: [PATCH] clk: convert ARM RealView to common clk
In-Reply-To: <1344426753.2435.40.camel@hornet>
References: <1344270728-7550-1-git-send-email-linus.walleij@stericsson.com>
 <1344426500.2435.39.camel@hornet> <1344426753.2435.40.camel@hornet>
Message-ID: <CACRpkdYkoeH09H6c4WEw40hpP9+oRD4pa0-yBk1L02yfao2sgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 8, 2012 at 1:52 PM, Pawel Moll <pawel.moll@arm.com> wrote:

>> ------------[ cut here ]------------
>> WARNING: at /home/pawmol01/src/kernel.org/linux/kernel/timer.c:1076 del_timer_sync+0x34/0x5c()
>
> Err. Ignore that. The same happens without your patch :-)
>
> Will try with 3.5.

Hm it boots like a charm on PB1176, what's so very different about the EB?

Oh well. Are you maintaining RealView EB, BTW?

Yours,
Linus Walleij
