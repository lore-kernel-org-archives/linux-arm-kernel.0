From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 May 2017 16:41:50 +0200
Subject: [PATCH v2 04/10] pinctrl: sunxi: switch A20's pinctrl driver to
 use the A10 version
In-Reply-To: <20170504135006.16483-5-icenowy@aosc.io>
References: <20170504135006.16483-1-icenowy@aosc.io>
 <20170504135006.16483-5-icenowy@aosc.io>
Message-ID: <CACRpkdapcjoSaCpKev6tTuMVF5ZEQ61HkUMMAC3npJnnYWzNcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 4, 2017 at 3:50 PM, Icenowy Zheng <icenowy@aosc.io> wrote:

> As we added A20 support to A10 pinctrl driver, now we can delete the
> dedicated A20 pinctrl driver, and enable A10 driver for A20.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Looks all right to me but I'm waiting for Maxime's review on these
patches.

Yours,
Linus Walleij
