From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 13 Mar 2012 15:48:24 +0530
Subject: [PATCH 0/5] pinctrl: add new Samsung pinctrl driver and add
 Exynos4 support
In-Reply-To: <CACRpkdYB4ambuDeMUX1kZn793xxfaaNjQ56EB4C8OAykMxoPJQ@mail.gmail.com>
References: <1331469965-28846-1-git-send-email-thomas.abraham@linaro.org>
 <CACRpkdYB4ambuDeMUX1kZn793xxfaaNjQ56EB4C8OAykMxoPJQ@mail.gmail.com>
Message-ID: <CAJuYYwSUepRJuwdtDUGu6frCsHvvtmDEUrXEHKitYJppWwL0aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 March 2012 15:43, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sun, Mar 11, 2012 at 1:46 PM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
>
>> This patch series adds new pinctrl driver for Samsung SoC's. The driver supports
>> a gpiolib interface as well since Samsung SoC's have a combined pinmux/pinctrl
>> and gpio controller.
>
> Overall this all looks good to me Thomas!
> I will provide detailed review if/when it is more ripe for merge.

Thanks linus for having a look. The missing bits in the driver are
wakeup interrupt and gpio interrupt support. Without these, it would
not be possible to meaningfully demonstrate a fully functional system
using the pinctrl and gpiolib driver for Exynos4.

Regards,
Thomas.

>
> Yours,
> Linus Walleij
