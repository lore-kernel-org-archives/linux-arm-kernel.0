From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 Jan 2013 15:24:37 +0100
Subject: [PATCH v7 06/15] gpio: find gpio base by ascend order
In-Reply-To: <1358494279-16503-7-git-send-email-haojian.zhuang@linaro.org>
References: <1358494279-16503-1-git-send-email-haojian.zhuang@linaro.org>
 <1358494279-16503-7-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdZ1vWjFjx7-J-Wpjkz0rf4kf6WiVXpBhyhReSFMfcztwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 18, 2013 at 8:31 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> gpiochip_find_base() always tries to find valid gpio with descend order.
> It's inconvient if gpio information is passing from DTS. Now try to find
> valid gpio with ascend order.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Grant, can you comment on this?

You know DT and GPIO better than me....

Yours,
Linus Walleij
