From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 2 Jun 2015 15:41:58 +0200
Subject: [PATCH v2 6/6] ARM: brcmstb: Add default gpio number
In-Reply-To: <1432865650-4062-7-git-send-email-gregory.0xf0@gmail.com>
References: <1432865650-4062-1-git-send-email-gregory.0xf0@gmail.com>
 <1432865650-4062-7-git-send-email-gregory.0xf0@gmail.com>
Message-ID: <CACRpkdYYkPxm_K82YnzYDKDv4sFODCkQFVck_M=y6sBehmy7qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 29, 2015 at 4:14 AM, Gregory Fong <gregory.0xf0@gmail.com> wrote:

> Out of the brcmstb SoCs that I know, BCM3390 has the largest numbers
> of GPIOs, with its
> - 320 "peripheral" GPIOs
> - 5*32 = 160 UPG GPIOs (counting unused lines, which do get counted)
> - 2*32 = 64 UPG AON GPIOs (counting unused lines)
> Total: 544
>
> I suspect that the upper limit will only need to be higher in the
> future, so set it to 1024.
>
> Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
