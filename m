From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 7 Aug 2012 08:56:10 +0200
Subject: [PATCH 3/4] gpio/mxs: specify gpio base for device tree probe
In-Reply-To: <20120806135110.GA24289@S2101-09.ap.freescale.net>
References: <1344146488-9496-1-git-send-email-shawn.guo@linaro.org>
 <1344146488-9496-3-git-send-email-shawn.guo@linaro.org>
 <CACRpkdZz+F8gUGJG+d2mGrt8Rp0NzYypGdLEUbxmh=X1Q1cFhw@mail.gmail.com>
 <20120806135110.GA24289@S2101-09.ap.freescale.net>
Message-ID: <CACRpkdZ3HkkcjYLd_pcsmjDwjt26HfU0X9QV87Bmkx5tAQtXZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 6, 2012 at 3:51 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Sun, Aug 05, 2012 at 11:48:24AM +0200, Linus Walleij wrote:
>> On Sun, Aug 5, 2012 at 8:01 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
>>
>> > Currently, unlike the non-DT probe where the gpio base is specified
>> > with pdev->id, the DT probe uses the base dynamically allocated by
>> > gpio core, which uses a completely different numbering scheme.  This
>> > causes two issues to user space applications which access sysfs entry
>> > /sys/class/gpio/gpioN.
>>
>> Applied.
>>
> Sorry, Linus.  I just recall gpio-mxs driver already reads alias to
> assign port->id for DT boot at the beginning of probe function, and
> this patch is completely a noise therefore.  So can you please drop
> the patch from you branch?  Sorry again.

OK dropped this patch...

Yours,
Linus Walleij
