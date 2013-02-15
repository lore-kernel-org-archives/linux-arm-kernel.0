From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 15 Feb 2013 09:54:29 +0100
Subject: [PATCH v8 09/12] pinctrl: generic: add auto pull config parameter
In-Reply-To: <1360602659-4774-10-git-send-email-haojian.zhuang@linaro.org>
References: <1360602659-4774-1-git-send-email-haojian.zhuang@linaro.org>
 <1360602659-4774-10-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <CACRpkdYKAexLu30M2KzKcRcvRJS=xfVMB2vR+CgAXmwQ0+_ZzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 11, 2013 at 6:10 PM, Haojian Zhuang
<haojian.zhuang@linaro.org> wrote:

> There's only one bit to control pin bias as enabled or disabled for some
> pins in OMAP SoC. So append PIN_CONFIG_BIAS_AUTO_PULL for this case.
> User shouldn't switch pin state between AUTO_PULL and PULL_UP/PULL_DOWN,
> since they're similiar concepts.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

Makes perfect sense.
Patch applied with Tony's ACK!

Yours,
Linus Walleij
