From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Nov 2012 15:31:13 +0100
Subject: [PATCH] pinctrl: Drop selecting PINCONF for MMP2,
 PXA168 and PXA910
In-Reply-To: <1352702020.15066.2.camel@phoenix>
References: <1352702020.15066.2.camel@phoenix>
Message-ID: <CACRpkdbE+GdUP4DHQvrD3YitUkizSxe=4X8HbcLL0a3AfxD4qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2012 at 7:33 AM, Axel Lin <axel.lin@ingics.com> wrote:
> These drivers do not need to select PINCONF.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

I'm a bit uncertain as to why they still select PINCONF, Haojian
can you check this patch before I apply it?

Yours,
Linus Walleij
