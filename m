From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 Mar 2016 10:32:11 +0200
Subject: [PATCH v2] gpio/ls1021a: Add gpio support for ls1021a platform
In-Reply-To: <1458726442-1851-2-git-send-email-Gang.Liu@nxp.com>
References: <1458726442-1851-1-git-send-email-Gang.Liu@nxp.com>
 <1458726442-1851-2-git-send-email-Gang.Liu@nxp.com>
Message-ID: <CACRpkdZzgYMUkJHMzxZkTFRR44R+XRe77aMz89Hj=y-ZQ15qgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The subject of this patch should be:

ARM: dts: ...

And it should be merged through the ARM SoC tree.

On Wed, Mar 23, 2016 at 10:47 AM, Liu Gang <Gang.Liu@nxp.com> wrote:

> Add gpio nodes for ls1021a platform dts file. The gpio
> IP block of the ls1021a can be supported by the code
> drivers/gpio/gpio-mpc8xxx.c.
>
> The compatible "fsl,qoriq-gpio" is used by gpio driver:
> drivers/gpio/gpio-mpc8xxx.c to implement general gpio
> functionalities.
>
> The chip-specific compatible "fsl,ls1021a-gpio" may be
> used to fix potential gpio IP block errata or other
> chip-specific gpio issues.
>
> Signed-off-by: Liu Gang <Gang.Liu@nxp.com>

Apart from that it looks OK.

Yours,
Linus Walleij
