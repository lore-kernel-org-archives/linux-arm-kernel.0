From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 9 Aug 2011 12:07:02 +0200
Subject: [PATCH] GPIOLIB: add generic gpio_set_pull API
In-Reply-To: <CAH9JG2V-66Wn7nwJz6tOkESoQAUJzAg-47YeMY0vzwu6T9O=Rg@mail.gmail.com>
References: <1312780773-23142-1-git-send-email-Baohua.Song@csr.com>
	<20110808081552.GI32513@linux-sh.org>
	<CACxGe6ssT4=kxApaKhv+=7nDcEFVW+oyByFQ_hzcfyZ4gw2C3g@mail.gmail.com>
	<CAH9JG2V-66Wn7nwJz6tOkESoQAUJzAg-47YeMY0vzwu6T9O=Rg@mail.gmail.com>
Message-ID: <CACRpkdaoLYiqgR9vyU2ww6WjtW8Pox2uguKyQowj1iSdESV=6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 9, 2011 at 12:57 AM, Kyungmin Park <kmpark@infradead.org> wrote:

> If gpiolib accept the pullup control. gpiolib is better place to
> control gpio config.
> then remains are the gpio driver strength, and power down mode
> control. powerdown pull-up/down, powerdown in/out at samsung gpios.

I agree. And this is what I need to move the U300 and Nomadik
GPIO drivers over to struct gpio_chip.

Yours,
Linus Walleij
