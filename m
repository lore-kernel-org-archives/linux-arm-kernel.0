From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 24 Sep 2015 14:50:16 -0700
Subject: [PATCH v3 3/9] gpiolib: Use GPIO name from names array for gpio
 descriptor
In-Reply-To: <20150923220237.GC19608@localhost>
References: <1439561466-14350-1-git-send-email-mpa@pengutronix.de>
 <1439561466-14350-4-git-send-email-mpa@pengutronix.de>
 <20150923220237.GC19608@localhost>
Message-ID: <CACRpkdbUevNvOQta=VDnQh7z8Z6hK4CbskixN+VtRQpwEYboCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 23, 2015 at 3:02 PM, Johan Hovold <johan@kernel.org> wrote:

> Before figuring out what a sane userspace interface should look like we
> should not make ABI changes that we need to support indefinitely. The
> legacy sysfs interface should instead be frozen.
>
> Exposing a name attribute for a not-necessarily globally unique name
> could perhaps be ok, but by enforcing uniqueness at this point we will
> then need to come up with another mechanism for naming gpios on dynamic
> buses (while maintaining this one indefinitely in parallel).
>
> Linus, please consider dropping these changes for now.

I rounded off the series after moving the name attribute to the descriptor
before doing any ABI changes, as it seems we need to discuss this.

This patch concludes that part of the series, sent a separate patch
concluding this first half of the series.

Yours,
Linus Walleij
