From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 Aug 2017 11:23:17 +0200
Subject: [PATCH v2 1/3] gpio: davinci: Use devm_gpiochip_add_data in place
 of gpiochip_add_data
In-Reply-To: <1500543738-9696-2-git-send-email-j-keerthy@ti.com>
References: <1500543738-9696-1-git-send-email-j-keerthy@ti.com>
 <1500543738-9696-2-git-send-email-j-keerthy@ti.com>
Message-ID: <CACRpkdZ3EJNBJ38nVV+YZd82KNWrCaJk0SRiwku_xjoE+PApWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 11:42 AM, Keerthy <j-keerthy@ti.com> wrote:

> Use the devm version of gpiochip_add_data and pass on the
> return value. This avoids memory leak due to gpiochip_add_data
> in case the driver is unbound.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>

Patch applied.

Yours,
Linus Walleij
