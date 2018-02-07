From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Feb 2018 13:31:58 +0100
Subject: [PATCH] pinctrl: meson-axg: adjust uart_ao_b pin group naming
In-Reply-To: <20180118141757.41290-1-yixun.lan@amlogic.com>
References: <20180118141757.41290-1-yixun.lan@amlogic.com>
Message-ID: <CACRpkdYvC3wokib4ixjzJ8wWSTU1XQ90ix+iH_3vh70xOnkCcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 18, 2018 at 3:17 PM, Yixun Lan <yixun.lan@amlogic.com> wrote:

> Simply adjust the pin group to _x _y _z style, as to
> keep the consistency in DT with previous naming scheme.
>
> Fixes: 83c566806a68 ("pinctrl: meson-axg: Add new pinctrl driver for Meson AXG SoC")
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

Patch applied for fixes.

Yours,
Linus Walleij
