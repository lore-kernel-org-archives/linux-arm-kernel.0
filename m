From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 16 May 2018 16:23:39 +0200
Subject: [PATCH 1/2] pinctrl: nand: meson-gxbb: fix missing data pins
In-Reply-To: <20180509220827.22286-2-yixun.lan@amlogic.com>
References: <20180509220827.22286-1-yixun.lan@amlogic.com>
 <20180509220827.22286-2-yixun.lan@amlogic.com>
Message-ID: <CACRpkdZeUxNOxHSC1AYoR6TG0DUsXt3p9m-SWDaQDyAooNYUyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2018 at 12:08 AM, Yixun Lan <yixun.lan@amlogic.com> wrote:

> The data pin 0-7 of the NAND controller are actually missing from
> the nand pinctrl group, so we fix it here.
>
> Fixes: cd1e3b01c7d3 ("pinctrl: amlogic: gxbb: add nand pins")
> Reported-by: Liang Yang <liang.yang@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

Patch applied.

Yours,
Linus Walleij
