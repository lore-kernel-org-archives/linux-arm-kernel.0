From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 8 Mar 2012 07:16:11 +0100
Subject: [PATCH] watchdog/coh901327: convert to use watchdog core
In-Reply-To: <20120307164240.GA1130@pengutronix.de>
References: <1331131929-22383-1-git-send-email-linus.walleij@stericsson.com>
 <20120307164240.GA1130@pengutronix.de>
Message-ID: <CACRpkdaE5HASdF27db7EfnSoaUF8mA5bWoKUhaAzSegdBKsKFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 7, 2012 at 5:42 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:

>> ? ? ? case WDIOC_GETTIMELEFT:
>> ? ? ? ? ? ? ? clk_enable(clk);
>> ? ? ? ? ? ? ? /* Read repeatedly until the value is stable! */
>
> I was wondering if it pays to put this IOCTL to watchdog_dev and add another
> callback to watchdog_ops? I'd think so. Wim, Linus, what do you think?

OK with me, shall I hack a patch?

Yours,
Linus Walleij
