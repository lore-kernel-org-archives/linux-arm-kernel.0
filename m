From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 27 Nov 2014 14:29:47 +0100
Subject: [PATCHv2 05/16] gpio: mvebu: add suspend/resume support
In-Reply-To: <1415978496-9334-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1415978496-9334-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1415978496-9334-6-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdb5S7Fv4+Ck2btLPTYWaWr_E-iMcQGeATB4NMwx_T-4GA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 4:21 PM, Thomas Petazzoni
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

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Do you want me to merge the patch or is it dependent on other patches?

Yours,
Linus Walleij
