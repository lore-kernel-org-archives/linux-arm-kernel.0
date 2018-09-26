From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 26 Sep 2018 09:38:32 +0200
Subject: [PATCH 1/3] rtc: ab8500: use rtc_add_group
In-Reply-To: <20180924144902.607-1-alexandre.belloni@bootlin.com>
References: <20180924144902.607-1-alexandre.belloni@bootlin.com>
Message-ID: <CACRpkdYtU7J-0g8T9FzaGrbLkWEBPjn+xUZUq0AsJZcN=bvyXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2018 at 4:49 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:

> Use rtc_add_group to add the sysfs group in a race free manner.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
