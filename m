From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 31 Oct 2017 10:31:10 +0100
Subject: [PATCH v2 5/7] gpio: brcmstb: correct the configuration of level
 interrupts
In-Reply-To: <20171024195451.30535-6-opendmb@gmail.com>
References: <20171024195451.30535-1-opendmb@gmail.com>
 <20171024195451.30535-6-opendmb@gmail.com>
Message-ID: <CACRpkdbrEoJBVnS-1YoHsKuw3hBeuXuU_Gd2FKMD5bB2PRCHnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 24, 2017 at 9:54 PM, Doug Berger <opendmb@gmail.com> wrote:

> This commit corrects a bug when configuring the GPIO hardware for
> IRQ_TYPE_LEVEL_LOW and IRQ_TYPE_LEVEL_HIGH interrupt types. The
> hardware is now correctly configured to support those types.
>
> Fixes: 19a7b6940b78 ("gpio: brcmstb: Add interrupt and wakeup source support")
> Signed-off-by: Doug Berger <opendmb@gmail.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Acked-by: Gregory Fong <gregory.0xf0@gmail.com>

Patch applied.

Yours,
Linus Walleij
