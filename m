From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Oct 2016 13:53:49 +0200
Subject: [PATCH 6/8] pinctrl: aspeed-g4: Capture SuperIO pinmux dependency
In-Reply-To: <b5f67ba76018314d08e240f95951751896687d37.1474986045.git-series.andrew@aj.id.au>
References: <cover.115463f791b69859c5ce9dafd61a5755ea039f4b.1474986045.git-series.andrew@aj.id.au>
 <b5f67ba76018314d08e240f95951751896687d37.1474986045.git-series.andrew@aj.id.au>
Message-ID: <CACRpkdYLDesENtq2cQBrWQeL6NH+mO_N5Z=e9=gsoZSCE85Jag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2016 at 4:50 PM, Andrew Jeffery <andrew@aj.id.au> wrote:

> Two LPC-related signals in the AST2400 depend on state in the SuperIO IP
> block. Use the recently added infrastructure to capture this
> relationship.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Patch applied for v4.10.
(Tell me if I'm applying patches in wrong order or something, and
I hope this doesn't clash with the fixes.)

Yours,
Linus Walleij
