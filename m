From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 25 Jan 2013 10:51:32 +0100
Subject: [PATCH 01/10] gpio: pxa: set initcall level to module init
In-Reply-To: <1358929554-32265-2-git-send-email-haojian.zhuang@linaro.org>
References: <1358929554-32265-1-git-send-email-haojian.zhuang@linaro.org>
 <1358929554-32265-2-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdaZrxJBr-teqw9GSbS2vTR+iUSTkQNdieo0yL1r=Y7b9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 9:25 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> gpio & pinctrl driver are used together. The pinctrl driver is already
> launched before gpio driver in Makefile. So set gpio driver to module
> init level. Otherwise, the sequence will be inverted.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Applied to my devel branch.

Thanks!
Linus Walleij
