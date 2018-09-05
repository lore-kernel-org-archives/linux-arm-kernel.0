From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 5 Sep 2018 12:13:42 +0200
Subject: [PATCH -next] pinctrl: sirf: atlas7: remove set but not used
 variables 'conf, bank'
In-Reply-To: <1535681346-152447-1-git-send-email-yuehaibing@huawei.com>
References: <1535681346-152447-1-git-send-email-yuehaibing@huawei.com>
Message-ID: <CACRpkdY5qurpthqB8=ek5RhD3egXbceWi0RYK1P8pboH-KcA7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2018 at 3:58 AM YueHaibing <yuehaibing@huawei.com> wrote:

> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/pinctrl/sirf/pinctrl-atlas7.c: In function 'atlas7_pinmux_resume_noirq':
> drivers/pinctrl/sirf/pinctrl-atlas7.c:5545:6: warning:
>  variable 'bank' set but not used [-Wunused-but-set-variable]
>   u32 bank;
>
> drivers/pinctrl/sirf/pinctrl-atlas7.c:5543:28: warning:
>  variable 'conf' set but not used [-Wunused-but-set-variable]
>   struct atlas7_pad_config *conf;
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Patch applied.

Yours,
Linus Walleij
