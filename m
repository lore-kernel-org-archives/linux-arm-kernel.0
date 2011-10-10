From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Oct 2011 14:58:30 +0200
Subject: [PATCH] ARM: S3C64XX: Enable TCM support
In-Reply-To: <1318242473-19037-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1318242473-19037-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <CACRpkdYtH4SCk3o3W84u+pLwzaXnmU1OP7p631bC08QnP2bR9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 10, 2011 at 12:27 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:

> The S3C64xx CPUs have TCMs so enable the kernel support for it on these
> systems.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Cool! How big are they each, i.e. dmesg?

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
