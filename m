From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 4 Jul 2014 23:51:58 +0200
Subject: [PATCH RESEND 2/2] pinctrl: i.MX27: Remove nonexistent pad
 definitions
In-Reply-To: <1401813255-7897-2-git-send-email-shc_work@mail.ru>
References: <1401813255-7897-1-git-send-email-shc_work@mail.ru>
 <1401813255-7897-2-git-send-email-shc_work@mail.ru>
Message-ID: <CACRpkdYV-mrk_PuAeoX-kL-RowxpyEyHJzkCtuoCF9pFoKw97A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 3, 2014 at 6:34 PM, Alexander Shiyan <shc_work@mail.ru> wrote:

> Pads for PB0-PB3, PC0-PC4, PE26-PE31 and PF24-PF31 does not exist on
> the i.MX27 SOC. There is no reason to define them, the presence of
> such definitions in the DTS files is a bug.
> This patch removes these nonexistent pad definitions.
>
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Patch applied.

Maintainers may protest if they don't like this.

Yours,
Linus Walleij
