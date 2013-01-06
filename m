From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Jan 2013 00:51:20 +0100
Subject: [PATCH v6 6/8] tty: pxa: configure pin
In-Reply-To: <1356083118-18857-7-git-send-email-haojian.zhuang@linaro.org>
References: <1356083118-18857-1-git-send-email-haojian.zhuang@linaro.org>
 <1356083118-18857-7-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdbyQHge11kYG2z4=kJ4W4iHR-OSSNqfu_DeZ0Msg546yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 21, 2012 at 10:45 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> From: Haojian Zhuang <haojian.zhuang@gmail.com>
>
> Configure pins by pinctrl driver.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

I think this will not be needed if Greg ACKs my patch entitled
"drivers/pinctrl: grab default handles from device core"

No such simple grabbers will be needed anymore.

Yours,
Linus Walleij
