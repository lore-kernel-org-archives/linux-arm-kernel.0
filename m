From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 17 Jul 2012 20:17:45 +0200
Subject: [PATCH RESEND] gpio: of_get_named_gpio_flags() return
 -EPROBE_DEFER if GPIO not yet available
In-Reply-To: <20120717074324.GA12047@opensource.wolfsonmicro.com>
References: <1340836334-20427-1-git-send-email-stigge@antcom.de>
 <CACRpkdYrZizqvZqsocLEGrkY5yPMuYFfmR3UUSFZgPDvEPa0eA@mail.gmail.com>
 <20120715211120.GH4041@opensource.wolfsonmicro.com>
 <CACRpkdb0k4fNigA6FGyEobxUt-JnmUy-ni7XzH-gup-ic_j+VQ@mail.gmail.com>
 <20120717074324.GA12047@opensource.wolfsonmicro.com>
Message-ID: <CACRpkdaUfx6iiydHAwzZMG=a5y5kcoB+zeaVTvXjcPArGX8bMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2012 at 9:43 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Jul 17, 2012 at 12:16:48AM +0200, Linus Walleij wrote:
>> On Sun, Jul 15, 2012 at 11:11 PM, Mark Brown
>
>> > I had thought a version of this
>> > had been submitted already and was in a similar place to the one for
>> > gpio_request().
>
>> Me to...
>
> Greg just merged the driver core patch for pushing the deferred devices
> to the end of the dpm list before reprobing them which should address
> Grant's concern about doing this in gpiolib.

OK sounds good, I'll look over your patch again.

Yours,
Linus Walleij
