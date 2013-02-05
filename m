From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 5 Feb 2013 18:15:54 +0100
Subject: [PATCH 4/9] gpiolib: use gpio_chips list in sysfs ops
In-Reply-To: <1359822572-26009-6-git-send-email-acourbot@nvidia.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
 <1359822572-26009-6-git-send-email-acourbot@nvidia.com>
Message-ID: <CACRpkdaC3pu3tBZrw0Az226XEt6+AzJ_NiiCaLwV9o6NUZ8MQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 2, 2013 at 5:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:

> This makes the code both simpler and faster compared to parsing the GPIO
> number space.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
