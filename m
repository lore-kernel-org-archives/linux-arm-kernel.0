From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 29 Jan 2013 12:02:48 +0100
Subject: [PATCH v2] ARM: mxs: gpio-mxs: Add IRQ_TYPE_EDGE_BOTH support
In-Reply-To: <1359447393-2570-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1359447393-2570-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <CACRpkdZcezOM-uNw=p9nfaZ0D2XOnMiy-4o4vyiqELrxL0afnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 9:16 AM, Gwenhael Goavec-Merou
<gwenhael.goavec-merou@armadeus.com> wrote:

> This patch adds support for IRQ_TYPE_EDGE_BOTH needed for some driver
> (gpio-keys).
> Inspired from gpio-mxc.c
>
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>

Applied, but I changed the subject to "gpio: mxs: ..."

Yours,
Linus Walleij
