From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 5 Feb 2013 18:04:43 +0100
Subject: [PATCH 2/9] gpiolib: use gpio_chips list in gpiolib_sysfs_init
In-Reply-To: <1359822572-26009-4-git-send-email-acourbot@nvidia.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
 <1359822572-26009-4-git-send-email-acourbot@nvidia.com>
Message-ID: <CACRpkdaz8h_1uKoH1q9gLmCxE0BMAxBakaq_eFfnfJr2V_Ct5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 2, 2013 at 5:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:

> Use the small list of GPIO chips instead of parsing the whole GPIO
> number space.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
