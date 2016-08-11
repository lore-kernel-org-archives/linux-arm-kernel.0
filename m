From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Aug 2016 14:10:24 +0200
Subject: [PATCH v7 1/5] mfd: tps65218: Remove redundant read wrapper
In-Reply-To: <1470833545-29462-2-git-send-email-j-keerthy@ti.com>
References: <1470833545-29462-1-git-send-email-j-keerthy@ti.com>
 <1470833545-29462-2-git-send-email-j-keerthy@ti.com>
Message-ID: <CACRpkdbLXDknZpVbofFC7dBb_4hLaurScXBDzL_xGtD+8AcBLA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2016 at 2:52 PM, Keerthy <j-keerthy@ti.com> wrote:

> Currently read directly calls the repmap read function. Hence
> remove the redundant wrapper and use regmap read wherever
> needed.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Acked-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I assume an immutable branch will not be needed for this,
this small changed "should not" collide with anything in
my tree (famous last words)...

Yours,
Linus Walleij
