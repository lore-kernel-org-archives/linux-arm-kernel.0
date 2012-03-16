From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Mar 2012 09:15:35 +0100
Subject: [PATCH] watchdog/coh901327: convert to use watchdog core
In-Reply-To: <20120315212705.GH10698@spo001.leaseweb.com>
References: <1331131929-22383-1-git-send-email-linus.walleij@stericsson.com>
 <20120307164240.GA1130@pengutronix.de>
 <CACRpkdaE5HASdF27db7EfnSoaUF8mA5bWoKUhaAzSegdBKsKFQ@mail.gmail.com>
 <20120315212705.GH10698@spo001.leaseweb.com>
Message-ID: <CACRpkdZ9tD8XQ3tOwTHMa3jOhivkwW7YZO0WZgG7r5BYDNktCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2012 at 10:27 PM, Wim Van Sebroeck <wim@iguana.be> wrote:
> Hi Linus,
>
>> On Wed, Mar 7, 2012 at 5:42 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>>
>> >> ? ? ? case WDIOC_GETTIMELEFT:
>> >> ? ? ? ? ? ? ? clk_enable(clk);
>> >> ? ? ? ? ? ? ? /* Read repeatedly until the value is stable! */
>> >
>> > I was wondering if it pays to put this IOCTL to watchdog_dev and add another
>> > callback to watchdog_ops? I'd think so. Wim, Linus, what do you think?
>>
>> OK with me, shall I hack a patch?
>
> I think Viresh did something allready.

OK I rebased on top of Viresh's patch and sent them both out since
I don't know the status of his patch.

If you already have Viresh's patch in your tree just applying 2/2
should work as fine.

Yours,
Linus Walleij
