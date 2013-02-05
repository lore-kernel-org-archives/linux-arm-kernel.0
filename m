From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 5 Feb 2013 18:02:47 +0100
Subject: [PATCH v8 02/12] gpio: fix wrong checking condition for gpio range
In-Reply-To: <1359825953-15663-3-git-send-email-haojian.zhuang@linaro.org>
References: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
 <1359825953-15663-3-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdbeqns08GV6hybH-ww8r-xM96TL+Go0jYpEJRn03uRU7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 2, 2013 at 6:25 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> If index++ calculates from 0, the checking condition of "while
> (index++)" fails & it doesn't check any more. It doesn't follow
> the loop that used at here.
>
> Replace it by endless loop at here. Then it keeps parsing
> "gpio-ranges" property until it ends.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
