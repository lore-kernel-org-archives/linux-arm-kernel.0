From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Sep 2018 09:40:05 +0200
Subject: [PATCH 3/3] rtc: ab8500: remove useless check
In-Reply-To: <20180924144902.607-3-alexandre.belloni@bootlin.com>
References: <20180924144902.607-1-alexandre.belloni@bootlin.com>
 <20180924144902.607-3-alexandre.belloni@bootlin.com>
Message-ID: <CACRpkdZ97txAe+Nm_AKTQsBEfcq8ShVZOwv_fcHBk4w4t2bgSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2018 at 4:49 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> rtc_time_to_tm always rturns a valid tm, there is no need to validate it.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
