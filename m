From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 Jan 2013 15:15:02 +0100
Subject: [PATCH v7 02/15] pinctrl: core: get devname from pinctrl_dev
In-Reply-To: <1358494279-16503-3-git-send-email-haojian.zhuang@linaro.org>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
 <1358494279-16503-3-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdYBDL9fmmREQt5-=FTA9PL678xQkXF0Mr48433jxt=mEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 18, 2013 at 8:31 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Add new function to get devname from pinctrl_dev. pinctrl_dev_get_name()
> can only get pinctrl description name. If we want to use gpio driver to
> find pinctrl device node, we need to fetch the pinctrl device name.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Looks helpful in its own right, patch applied!

Yours,
Linus Walleij
