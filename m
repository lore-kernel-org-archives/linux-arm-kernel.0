From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 May 2015 11:41:41 +0200
Subject: [PATCH] pinctrl: Fix gpio/pin mapping for Meson8b
In-Reply-To: <1431878258-10229-1-git-send-email-carlo@caione.org>
References: <1431878258-10229-1-git-send-email-carlo@caione.org>
Message-ID: <CACRpkdYYVHOX0aHz3Wq9_R1N7Dc0BqSk90hBs+qGMK893fqezQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 17, 2015 at 5:57 PM, Carlo Caione <carlo@caione.org> wrote:

> From: Carlo Caione <carlo@endlessm.com>
>
> The num_pins field in the struct meson_domain_data must include also the
> missing pins in the Meson8b SoC, otherwise the GPIO <-> pin mapping is
> broken on this platform. Avoid also the dinamic allocation for GPIOs.
>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>

Patch applied for fixes.

Yours,
Linus Walleij
