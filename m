From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 11 Mar 2014 11:15:04 +0100
Subject: [PATCH v2] gpio: davinci: fix gpio selection for OF
In-Reply-To: <1394018461-757-1-git-send-email-holler@ahsoftware.de>
References: <5316FFCE.1060603@ti.com>
 <1394018461-757-1-git-send-email-holler@ahsoftware.de>
Message-ID: <CACRpkdaF=jc9Z1XZCtH8VPuih01t--qyV-sgH1R_ix0VM4RzVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 5, 2014 at 12:21 PM, Alexander Holler <holler@ahsoftware.de> wrote:

> The driver missed an of_xlate function to translate gpio numbers
> as found in the DT to the correct chip and number.
>
> While there I've set #gpio_cells to a fixed value of 2.
>
> I've used gpio-pxa.c as template for those changes and tested my changes
> successfully on a da850 board using entries for gpio-leds in a DT. So I didn't
> reinvent the wheel but just copied and tested stuff.
>
> Thanks to Grygorii Strashko for the hint to the existing code in gpio-pxa.
>
> Signed-off-by: Alexander Holler <holler@ahsoftware.de>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

This v2 version applied, thanks!

Yours,
Linus Walleij
