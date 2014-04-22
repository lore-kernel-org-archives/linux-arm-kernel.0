From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Apr 2014 17:02:38 +0200
Subject: [PATCH 1/7] gpiolib: gpiolib-of: Implement device tree gpio-names
 based lookup
In-Reply-To: <1397544101-18135-2-git-send-email-wens@csie.org>
References: <1397544101-18135-1-git-send-email-wens@csie.org>
 <1397544101-18135-2-git-send-email-wens@csie.org>
Message-ID: <CACRpkdZDjC1KxM2yJqsgpg2MxBamX1EObsuahB-2c+ShuBXm8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 15, 2014 at 8:41 AM, Chen-Yu Tsai <wens@csie.org> wrote:

> This patch provides of_get_gpiod_flags_by_name(), which looks up GPIO
> phandles by name only, through gpios/gpio-names, and not by index.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Like Alexandre I have no strong opinion on this alternative scheme.

However if I shall apply this patch I want ACKs from the DT maintainers
with them expressing that they want things to look like this going
forward.

Otherwise the set is stalled right here.

Yours,
Linus Walleij
