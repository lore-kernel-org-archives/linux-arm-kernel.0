From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 1 Mar 2013 13:54:58 +0100
Subject: [PATCH v9 05/10] gpio: pl061: bind pinctrl by gpio request
In-Reply-To: <1361101376-3783-6-git-send-email-haojian.zhuang@linaro.org>
References: <1361101376-3783-1-git-send-email-haojian.zhuang@linaro.org>
 <1361101376-3783-6-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdZbr_e8Jfdj5R7zmrgCYvcOyYu5AQu57XbYrHYKyzk=ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 17, 2013 at 12:42 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Add the pl061_gpio_request() to request pinctrl. Create the logic
> between pl061 gpio driver and pinctrl (pinctrl-single) driver.
>
> While a gpio pin is requested, it will request pinctrl driver to
> set that pin with gpio function mode. So pinctrl driver should
> append .gpio_request_enable() in pinmux_ops.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Patch applied to the pinctrl tree for v3.10.

Thanks,
Linus Walleij
