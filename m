From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Feb 2013 19:58:26 +0100
Subject: [PATCH v3 04/12] gpio: pxa: remove gpio_type
In-Reply-To: <1361164358-5845-5-git-send-email-haojian.zhuang@linaro.org>
References: <1361164358-5845-1-git-send-email-haojian.zhuang@linaro.org>
 <1361164358-5845-5-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdYN-B=Qze0dKjPEetrrYCZZ0sC3jUSNnOGXO7o6TMnEyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 18, 2013 at 6:12 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Since gpio_type is used to check whether gafr register is valid. So
> move it into platform data.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Looks clean an nice,
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
