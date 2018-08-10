From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 10 Aug 2018 12:25:45 +0200
Subject: [RFC PATCH v2 05/12] mtd: rawnand: ams-delta: use GPIO API for
 data read/write
In-Reply-To: <20180806222918.12644-6-jmkrzyszt@gmail.com>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-1-jmkrzyszt@gmail.com>
 <20180806222918.12644-6-jmkrzyszt@gmail.com>
Message-ID: <CACRpkdagqyuhxtv43UezqcKZvvUbOrHB3Cz9oaHT5X+64WaZQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 7, 2018 at 12:29 AM Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Don't readw()/writew() data directly from/to GPIO port which is under
> control of gpio-omap driver, use GPIO API instead.
>
> Degrade of performance on Amstrad Delta is completely not acceptable.
>
> The driver should work with any 8+-bit bidirectional GPIO port, not
> only OMAP.
>
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
