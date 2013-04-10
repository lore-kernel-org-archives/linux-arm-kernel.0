From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Apr 2013 22:59:39 +0200
Subject: [PATCH 1/3] ARM: pxa: remove cpu_is_xxx in gpio driver
In-Reply-To: <1365556707-9159-1-git-send-email-haojian.zhuang@linaro.org>
References: <1365556707-9159-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdbr=VT8g03S=KUMUReJe+6aU0n1Pfy2nk=XErKfYojwBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 3:18 AM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> Avoid to use cpu_is_xxx() in pxa gpio driver. Use platform_device_id
> to identify the difference.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I guess this will go through some PXA/MMP tree?

Yours,
Linus Walleij
