From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 2 Dec 2012 00:08:19 +0100
Subject: [PATCH RESEND] pinctrl: Drop selecting PINCONF for MMP2, PXA168
 and PXA910
In-Reply-To: <1354084640.18972.1.camel@phoenix>
References: <1354084640.18972.1.camel@phoenix>
Message-ID: <CACRpkdYwqGzHZb2Hj0=4Mghv6NS66nCdPBVbBD0wkjSy_EZgxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2012 at 7:37 AM, Axel Lin <axel.lin@ingics.com> wrote:

> These drivers do not need to select PINCONF.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> This patch was sent on https://lkml.org/lkml/2012/11/12/12.
> Resend to Haojian's correct email address.

Applied. PXA guys can scream if they don't like it :-)

Yours,
Linus Walleij
