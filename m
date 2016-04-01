From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 1 Apr 2016 14:47:26 +0200
Subject: [PATCH] pinctrl: bcm2835: Implement get_direction callback
In-Reply-To: <1459177104-24353-1-git-send-email-stefan.wahren@i2se.com>
References: <1459177104-24353-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <CACRpkdaE3UKM3dhydXmHfFMUJ5r7murX3baYmm0ug9Y8P4G7HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 28, 2016 at 4:58 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:

> Implement gpio_chip's get_direction() callback, that lets other
> drivers get particular GPIOs direction using gpiod_get_direction().
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Patch applied with the ACKs.

Yours,
Linus Walleij
