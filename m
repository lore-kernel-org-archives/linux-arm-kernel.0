From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 28 Jan 2013 11:22:50 +0100
Subject: [PATCH] ARM: mxs: gpio-mxs: Add IRQ_TYPE_EDGE_BOTH support
In-Reply-To: <1359306248-28690-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1359306248-28690-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <CACRpkdadTBrnbw4+oqcwbSiBM4BjBmBEEpmrtw7DpALTEp9j=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 27, 2013 at 6:04 PM, Gwenhael Goavec-Merou
<gwenhael.goavec-merou@armadeus.com> wrote:

> This patch adds support for IRQ_TYPE_EDGE_BOTH needed for some driver
> (gpio-keys).
> Inspired from gpio-mxc.c
>
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>

Looks correct to me, Shawn do you ACK this?

Yours,
Linus Walleij
