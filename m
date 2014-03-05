From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 5 Mar 2014 10:27:59 +0800
Subject: [PATCH] gpio: davinci: fix gpio selection for OF
In-Reply-To: <1393970762-5346-1-git-send-email-holler@ahsoftware.de>
References: <5315ED51.1000006@ti.com>
 <1393970762-5346-1-git-send-email-holler@ahsoftware.de>
Message-ID: <CACRpkdb2ECPyTcGkt7XcBt9HP1335xXHjxKZpYR4Dd3K+YmDYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 5, 2014 at 6:06 AM, Alexander Holler <holler@ahsoftware.de> wrote:

> The driver missed an of_xlate function to translate gpio numbers
> as found in the DT to the correct chip and number.
>
> While there I've set #gpio_cells to a fixed value of 2.
>
> I've used gpio-pxa.c as template for those changes and tested my changes
> successfully on a da850 board using entries for gpio-leds in a DT. So I didn't
> reinvent the wheel but just copied and tested stuff.
>
> Thanks to Grygorii Strashko for the hint of the existing code in gpio-pxa.
>
> Signed-off-by: Alexander Holler <holler@ahsoftware.de>

Grygorii, can I have your review tag on this patch so I can apply it?

Yours,
Linus Walleij
