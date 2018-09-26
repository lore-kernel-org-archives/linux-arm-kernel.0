From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Sep 2018 09:39:26 +0200
Subject: [PATCH 2/3] rtc: ab8500: let the core handle range
In-Reply-To: <20180924144902.607-2-alexandre.belloni@bootlin.com>
References: <20180924144902.607-1-alexandre.belloni@bootlin.com>
 <20180924144902.607-2-alexandre.belloni@bootlin.com>
Message-ID: <CACRpkdYsuh2rXsW9KJz7Vaj_nH4ierpOE+G7tbrzkN2NDhgiuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2018 at 4:49 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> Let the core handle offsetting and windowing the RTC range.
> The RTC has a 24 bit counter for minutes plus a seconds counter.
> Keep the epoch at the beginning of 2000.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
