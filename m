From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 May 2013 22:36:15 +0200
Subject: [PATCH] arm/mach-u300/dummyspichip: Use module_spi_driver to
 register driver
In-Reply-To: <1369081324-8062-1-git-send-email-peterhuewe@gmx.de>
References: <1369081324-8062-1-git-send-email-peterhuewe@gmx.de>
Message-ID: <CACRpkdZvkRh1jEL9rtZMDb1ZBezvYeijFRsJfruQ8igA1+axHQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 20, 2013 at 10:22 PM, Peter Huewe <peterhuewe@gmx.de> wrote:

> Removing some boilerplate by using module_spi_driver instead of calling
> register and unregister in the otherwise empty init/exit functions.
>
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>

Applied to my U300 branch for v3.11, thanks!

Yours,
Linus Walleij
