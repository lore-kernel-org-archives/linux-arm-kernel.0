From: olof@lixom.net (Olof Johansson)
Date: Wed, 11 Sep 2013 09:27:11 -0700
Subject: [PATCH] mtd: nand: pxa3xx: Add pxa3xx_nand_get_variant() stub for
 !CONFIG_OF
In-Reply-To: <1378916185-19738-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1378916185-19738-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <CAOesGMi00E-AFHRBZdkirECFoeO9FthPDSaeTCURBGQp-gpvWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 11, 2013 at 9:16 AM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> This commit adds a dummy pxa3xx_nand_get_variant() stub, to fix
> this build error (with pxa3xx_defconfig or similar):
>
> drivers/mtd/nand/pxa3xx_nand.c:1325:2: error: implicit declaration of
> function 'pxa3xx_nand_get_variant' [-Werror=implicit-function-declaration]
>
> Cc: Brian Norris <computersforpeace@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Nack. This has already been fixed by you(!), Brian is just sitting on
the patch and not sending it up for some reason. Brian?


-Olof
