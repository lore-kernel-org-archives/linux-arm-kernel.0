From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 Aug 2011 14:43:48 +0200
Subject: [PATCH 1/3] gpio/nomadik: remove pull-pinconfig and add SPI2
In-Reply-To: <1312913020-7508-1-git-send-email-linus.walleij@stericsson.com>
References: <1312913020-7508-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CACRpkdZngg7mazP2XqdvyPXBRZs519a_R12Vss5K3oQhtMhv1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 9, 2011 at 8:03 PM, Linus Walleij
<linus.walleij@stericsson.com> wrote:

> From: Fredrik Svensson <fredrik.xk.svensson@stericsson.com>
>
> Remove PIN_CFG_PULL in pincfg.h for plat-nomadik, PIN_CFG_INPUT
> already takes care of this. Added support for SPI2.
>
> Signed-off-by: Fredrik Svensson <fredrik.xk.svensson@stericsson.com>
> Signed-off-by: Daniel Willerud <daniel.willerud@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ?arch/arm/mach-ux500/pins-db8500.h ? ? ? ? ? | ?142 ++++++++++++++-------------
> ?arch/arm/plat-nomadik/include/plat/pincfg.h | ? ?5 -
> ?2 files changed, 73 insertions(+), 74 deletions(-)

Since this one is only touching ux500 I'm picking it to the ux500-core
tree now, with new subject "mach-ux500: remove pull-pinconfig and add SPI2.

Makes for less conflicts anyway.

Still would like 2/3 and 3/3 to go into the gpio tree, knock knock :-)

Yours,
Linus Walleij
