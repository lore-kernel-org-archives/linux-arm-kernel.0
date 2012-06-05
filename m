From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 5 Jun 2012 14:46:18 +0200
Subject: [PATCH 3/3] gpio: exynos4: skip gpiolib registration if pinctrl
 driver is used
In-Reply-To: <1337816857-14694-4-git-send-email-thomas.abraham@linaro.org>
References: <1337816857-14694-1-git-send-email-thomas.abraham@linaro.org>
 <1337816857-14694-4-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CACRpkda1iiOFfjWbtJTf=R7qqHkzPbA3oTsWSiC08W_zctaexQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2012 at 1:47 AM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:

> Pinctrl driver, when enabled, registers all the gpio pins and hence the
> registration of gpio pins by this driver can be skipped.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I guess it's already applied... sorry for taking so long time
to respond.

Yours,
Linus Walleij
