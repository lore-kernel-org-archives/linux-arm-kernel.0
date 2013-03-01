From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 1 Mar 2013 13:45:56 +0100
Subject: [PATCH v9 02/10] gpio: fix wrong checking condition for gpio range
In-Reply-To: <1361101376-3783-3-git-send-email-haojian.zhuang@linaro.org>
References: <1361101376-3783-1-git-send-email-haojian.zhuang@linaro.org>
 <1361101376-3783-3-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdaCR1FnBq_YYj15hfsGn-+V1XyvoNfjJ7fQUE=Yp2TCXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 17, 2013 at 12:42 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> If index++ calculates from 0, the checking condition of "while
> (index++)" fails & it doesn't check any more. It doesn't follow
> the loop that used at here.
>
> Replace it by endless loop at here. Then it keeps parsing
> "gpio-ranges" property until it ends.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Patch applied to the fixes branch for the v3.9-rc series in
my pinctrl tree.

Yours,
Linus Walleij
