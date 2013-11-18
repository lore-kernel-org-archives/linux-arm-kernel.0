From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 18 Nov 2013 14:01:43 +0100
Subject: [PATCH v5 2/7] gpio: davinci: use readl/writel instead of __raw_*
In-Reply-To: <1383905510-31760-3-git-send-email-prabhakar.csengg@gmail.com>
References: <1383905510-31760-1-git-send-email-prabhakar.csengg@gmail.com>
 <1383905510-31760-3-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <CACRpkdbUpGdxCn6VZO+dVCsc-3SbFC4N_E49=MAEFHd5VXqRHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 8, 2013 at 11:11 AM, Prabhakar Lad
<prabhakar.csengg@gmail.com> wrote:
> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
>
> This patch replaces the __raw_readl/writel with
> readl and writel, Although the code runs on ARMv5
> based SOCs, changing this will help copying the code
> for other uses.
>
> Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
