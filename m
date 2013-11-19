From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 Nov 2013 10:30:30 +0100
Subject: [PATCH] pinctrl: imx: drop redundant OF dependency
In-Reply-To: <1384611454-24381-1-git-send-email-shawn.guo@linaro.org>
References: <1384611454-24381-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <CACRpkdb-+1Og4o9B=w7p8JmFhaCD-8SGB0tdabL_c1msHrkPSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 16, 2013 at 3:17 PM, Shawn Guo <shawn.guo@linaro.org> wrote:

> The IMX/MXC selects USE_OF at architecture level, so the OF dependency
> at individual SoC pinctrl driver level can just be dropped.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Patch applied.

Yours,
Linus Walleij
