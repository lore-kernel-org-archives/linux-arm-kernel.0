From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 1 Apr 2012 12:00:13 +0200
Subject: [PATCH] ARM: ux300: Fix unimplementable regulation constraints
In-Reply-To: <1333212293-6287-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1333212293-6287-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <CACRpkdaJMrO8FAkSAZEc9qMm2wFzF0F1HGjpbgAFkOEkRkzmLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 31, 2012 at 6:44 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:

> It doesn't make sense to grant permission to change the status of a
> regulator that is also set as always on and similarly it doesn't make
> sense to allow a driver to change the voltage of a regulator which can
> only be set to a single voltage.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Most probably correct.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Do you want me to funnel this to ARM-SoC or will you carry it in the
regulator tree?

Thanks,
Linus Walleij
