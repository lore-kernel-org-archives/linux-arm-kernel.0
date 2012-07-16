From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Jul 2012 00:16:48 +0200
Subject: [PATCH RESEND] gpio: of_get_named_gpio_flags() return
 -EPROBE_DEFER if GPIO not yet available
In-Reply-To: <20120715211120.GH4041@opensource.wolfsonmicro.com>
References: <1340836334-20427-1-git-send-email-stigge@antcom.de>
 <CACRpkdYrZizqvZqsocLEGrkY5yPMuYFfmR3UUSFZgPDvEPa0eA@mail.gmail.com>
 <20120715211120.GH4041@opensource.wolfsonmicro.com>
Message-ID: <CACRpkdb0k4fNigA6FGyEobxUt-JnmUy-ni7XzH-gup-ic_j+VQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 15, 2012 at 11:11 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, Jul 14, 2012 at 09:57:08PM +0200, Linus Walleij wrote:
>
>> If I understand correctly this relates closely to another patch from Mark Brown
>> we discussed the other day (sorry for missing this patch, which arrived
>> earlier, for a while).
>
>> Mark/Grant can you look at this patch?
>
> Not unless I have a copy of it, no...

Sorry, forwarded a copy to you.

> I had thought a version of this
> had been submitted already and was in a similar place to the one for
> gpio_request().

Me to...

Linus Walleij
