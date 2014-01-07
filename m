From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 7 Jan 2014 14:55:35 +0100
Subject: [PATCH] ARM: ux500: turn on PRINTK_TIME in u8500_defconfig
In-Reply-To: <1387225585-14107-1-git-send-email-olof@lixom.net>
References: <1387225585-14107-1-git-send-email-olof@lixom.net>
Message-ID: <CACRpkdYuJTZdxV_vgHBuFuCY300aEW7e2MrFM1mvhr1y5i3XZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 9:26 PM, Olof Johansson <olof@lixom.net> wrote:

> I recently noticed slow booting of a board, and without printk timestamps it's
> harder to tell just where the delays are coming from. Enable it.
>
> Signed-off-by: Olof Johansson <olof@lixom.net>

Patch applied.

I'll take a sweep on other ux500 misc patches and provide a pull
request to you get this back to ARM SoC by pingpong.

Yours,
Linus Walleij
