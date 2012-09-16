From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Sep 2012 00:24:13 +0200
Subject: [PATCH 13/24] ARM: nomadik: use __iomem pointers for MMIO
In-Reply-To: <1347658492-11608-14-git-send-email-arnd@arndb.de>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
 <1347658492-11608-14-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdYz-U2G6ZbJCbdoAAdEnCWfvDNovD0TyTs0kBdcn+U1Xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 11:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> ARM is moving to stricter checks on readl/write functions,
> so we need to use the correct types everywhere.
>
> Cc: Alessandro Rubini <rubini@unipv.it>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: STEricsson <STEricsson_nomadik_linux@list.st.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-nomadik/board-nhk8815.c           |    3 +--
>  arch/arm/mach-nomadik/include/mach/hardware.h   |    2 +-
>  arch/arm/mach-nomadik/include/mach/uncompress.h |    8 ++++----
>  3 files changed, 6 insertions(+), 7 deletions(-)

Looks good to me, thanks!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
