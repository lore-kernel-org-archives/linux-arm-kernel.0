From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 Mar 2016 10:29:02 +0200
Subject: [PATCH] gpio/ls2080a: Add compatible "fsl,ls2080a-gpio" for
 ls2080a gpio nodes
In-Reply-To: <1458726442-1851-4-git-send-email-Gang.Liu@nxp.com>
References: <1458726442-1851-1-git-send-email-Gang.Liu@nxp.com>
 <1458726442-1851-4-git-send-email-Gang.Liu@nxp.com>
Message-ID: <CACRpkdbRwTdGNsoCgqZbgf7DVYbPJdSDey7ju6ogVtVJ+tDGoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The subject of this patch should be:

ARM64: dts: ...

And it should be merged into the ARM SoC tree, not the GPIO tree.

On Wed, Mar 23, 2016 at 10:47 AM, Liu Gang <Gang.Liu@nxp.com> wrote:

> The compatible "fsl,qoriq-gpio" is used by gpio driver:
> drivers/gpio/gpio-mpc8xxx.c to implement general gpio
> functionalities.
>
> The chip-specific compatible "fsl,ls2080a-gpio" may be
> used to fix potential gpio IP block errata or other
> chip-specific gpio issues.
>
> Signed-off-by: Liu Gang <Gang.Liu@nxp.com>

Apart from that it looks good.

Yours,
Linus Walleij
