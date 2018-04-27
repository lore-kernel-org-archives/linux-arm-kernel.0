From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 27 Apr 2018 15:33:32 +0200
Subject: [PATCH] pinctrl: meson-axg: fix the range of aobus bank
In-Reply-To: <20180417170824.18670-1-yixun.lan@amlogic.com>
References: <20180417170824.18670-1-yixun.lan@amlogic.com>
Message-ID: <CACRpkdaRvKs=ekpxxW_NuxP=d5ijUafOHbpSk8igMUckbDWwyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2018 at 7:08 PM, Yixun Lan <yixun.lan@amlogic.com> wrote:

> The GPIOAO bank is range from GPIOAO_0 to GPIOAO_13.
>
> Fixes: 83c566806a68 ("pinctrl: meson-axg: Add new pinctrl driver for Meson AXG SoC")
> Reported-by: Xingyu Chen <xingyu.chen@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

Patch applied with Kevin's ACK.

Yours,
Linus Walleij
