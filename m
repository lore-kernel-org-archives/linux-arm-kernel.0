From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 16 Oct 2011 22:22:18 +0200
Subject: [PATCH 1/2] drivers: create a pin control subsystem v9
In-Reply-To: <CAPTzV15nEaE7kyH9XR36hTdg4xDRDsnnpTdqQ+2HSCEAQX=LvA@mail.gmail.com>
References: <1317629862-13549-1-git-send-email-linus.walleij@stericsson.com>
	<CAPTzV16bKaHxoyWEv1H8HGyY_CZhY9orXAuWA-wa0yb2NZ5UcA@mail.gmail.com>
	<CACRpkdY3scxhAw8dKENq=u0GNpSrkdpe5vKCemG7EWGvmFYxQg@mail.gmail.com>
	<CAPTzV15nEaE7kyH9XR36hTdg4xDRDsnnpTdqQ+2HSCEAQX=LvA@mail.gmail.com>
Message-ID: <CAKnu2MqLWmK023ZffczAsiN2cbf32nCjrjTb-inJk79TxmN42w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/14 Chanho Park <parkch98@gmail.com>:

> A gpio base number of gpio_range0 is 0 and pin base number is also 0.
> Converting gpio-pin number is no problem about the gpio_range0.
> A gpio base number of gpio_range1 is 32 but pin base number is 40(not 32).

Aha, I understand now, sorry I'm too slow in the head. :-/

Can you make a patch on top of the stuff that is currently
in linux-next adding the pin_base that you need?

I don't think there is any hurry of getting this in, but we sure
need to have it along with the first driver having this problem,
which I guess could be your driver.

Yours,
Linus Walleij
