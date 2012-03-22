From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Mar 2012 19:09:15 +0100
Subject: [PATCH] watchdog/coh901327: convert to use watchdog core
In-Reply-To: <20120322144950.GU10698@spo001.leaseweb.com>
References: <1331131929-22383-1-git-send-email-linus.walleij@stericsson.com>
 <20120307164240.GA1130@pengutronix.de>
 <CACRpkdaE5HASdF27db7EfnSoaUF8mA5bWoKUhaAzSegdBKsKFQ@mail.gmail.com>
 <20120315212705.GH10698@spo001.leaseweb.com>
 <CACRpkdZ9tD8XQ3tOwTHMa3jOhivkwW7YZO0WZgG7r5BYDNktCQ@mail.gmail.com>
 <20120322144950.GU10698@spo001.leaseweb.com>
Message-ID: <CACRpkdZ9iWVYSfnW4mRxvG8JxauV+ypjHbo25MCEp2HUzwqHyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 22, 2012 at 3:49 PM, Wim Van Sebroeck <wim@iguana.be> wrote:

> I added it. Only issue left is that you don't set the timeout value properly.
> This will result in faulty values for the WDIOC_GETTIMEOUT iotcl.
> Furthermore margin should be unsigned int. And there is also no check to see
> if margin is a valid parameter after it is loaded as a module.
>
> Could you test attached patch?

I cannot test it right now because I'm out of reach for the hardware,
but it looks good to me so:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

If I find any problems later I can surely fix them.

Yours,
Linus Walleij
