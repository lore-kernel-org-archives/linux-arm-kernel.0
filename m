From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 2 Dec 2012 00:09:46 +0100
Subject: [PATCH] ARM: mmp: select PINCTRL for ARCH_MMP
In-Reply-To: <1354084955.18972.2.camel@phoenix>
References: <1354084955.18972.2.camel@phoenix>
Message-ID: <CACRpkdZtsDHum36NvoCshOP1k+GkUU7WXtX_G9bD7G6-E_LNuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2012 at 7:42 AM, Axel Lin <axel.lin@ingics.com> wrote:

> This makes PINCTRL related config options visible.
> Otherwise there is no way to build pinctrl drivers for MMP2, PXA168 and PXA910.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> This patch was sent on https://lkml.org/lkml/2012/11/12/10
> Resend to Haojian's correct email address.

Applies this as well as an obvious fix.
ACK:s accepted...

Yours,
Linus Walleij
