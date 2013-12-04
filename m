From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 4 Dec 2013 13:28:41 +0100
Subject: [PATCH] gpio: MOXA ART: rename moxart_gpio_base to base
In-Reply-To: <1385980079-20175-1-git-send-email-jonas.jensen@gmail.com>
References: <1385723494-8033-1-git-send-email-jonas.jensen@gmail.com>
 <1385980079-20175-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <CACRpkdaT2fmfAwuyPTuF2Pim-_g5Avd_ViwQ069qRLFM9YBvWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 2, 2013 at 11:27 AM, Jonas Jensen <jonas.jensen@gmail.com> wrote:

> Renaming "moxart_gpio_base" to "base" allows better fit,
> remove line breaks in moxart_gpio_get().
>
> While doing trivial cleanup, also remove fields initialized
> with zero in moxart_template_chip.
>
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>

Patch applied!

Thanks!
Linus Walleij
