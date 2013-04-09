From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 9 Apr 2013 09:41:52 +0200
Subject: [PATCH 3/6] pinctrl: samsung: Split pin bank description into two
 structures
In-Reply-To: <1363642315-10331-4-git-send-email-tomasz.figa@gmail.com>
References: <1363642315-10331-1-git-send-email-tomasz.figa@gmail.com>
 <1363642315-10331-4-git-send-email-tomasz.figa@gmail.com>
Message-ID: <CACRpkdZewWoTT=EMd=pC_ESdRBU-O2q+syGvFX65WP9qEV9X_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 18, 2013 at 10:31 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:

> This patch splits pin bank description into two structures, one
> describing bank type (currently only bitfield widths), which can be
> shared across multiple banks and second containing bank-specific
> parameters including a pointer to a bank type struct.
>
> It is a prerequisite for further patch removing the statically hardcoded
> register offsets, making it impossible to support SoCs with different
> set and order of pin control registers.
>
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

Patch applied.

Yours,
Linus Walleij
