From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 4 Jul 2014 23:32:19 +0200
Subject: [PATCH v3 1/4] pinctrl: sunxi: Add IRQCHIP_SKIP_SET_WAKE flag for
 pinctrl irq chip
In-Reply-To: <1404051062-24079-2-git-send-email-hdegoede@redhat.com>
References: <1404051062-24079-1-git-send-email-hdegoede@redhat.com>
 <1404051062-24079-2-git-send-email-hdegoede@redhat.com>
Message-ID: <CACRpkdYt+QOURRfSRGnMUnN-U8qCW-1_1pVWiEP096ApAE79gA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 29, 2014 at 4:10 PM, Hans de Goede <hdegoede@redhat.com> wrote:

> From: Chen-Yu Tsai <wens@csie.org>
>
> The sunxi pinctrl irq chip driver does not support wakeup at the
> moment. Adding IRQCHIP_SKIP_SET_WAKE lets the irqs work with drivers
> using wakeup.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Patch applied.

Yours,
Linus Walleij
