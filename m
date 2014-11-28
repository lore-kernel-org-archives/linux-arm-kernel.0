From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 28 Nov 2014 12:55:16 +0100
Subject: [PATCHv3 05/16] gpio: mvebu: add suspend/resume support
In-Reply-To: <1416585613-2113-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1416585613-2113-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1416585613-2113-6-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdbPowMLHsw3+Ayi9zAJbd3Y8oTcnn=wb0H_Rmy74v8s7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 5:00 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> This commit adds the implementation of ->suspend() and ->resume()
> platform_driver hooks in order to save and restore the state of the
> GPIO configuration. In order to achieve that, additional fields are
> added to the mvebu_gpio_chip structure.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: linux-gpio at vger.kernel.org
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

I already have this patch applied to the GPIO tree, I guess you're
just resending the whole set on routine...

Yours,
Linus Walleij
