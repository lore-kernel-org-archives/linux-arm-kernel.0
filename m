From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 19 Feb 2016 00:20:53 +0100
Subject: [PATCH v2 3/5] gpio: ks8695: remove irq_to_gpio function
In-Reply-To: <1455637261-2920972-3-git-send-email-arnd@arndb.de>
References: <455637086-2794174-1-git-send-email-arnd@arndb.de>
 <1455637261-2920972-1-git-send-email-arnd@arndb.de>
 <1455637261-2920972-3-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdZEvuA2H7WaFtYtzOTRoZo1t5wpHu+O2oHGudoK63F8Gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 4:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The ks8695 gpio driver has its own copy of the irq_to_gpio()
> function. This is completely unused in the mainline kernel
> after we converted all remaining users several years ago,
> so we can remove the definition as well.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied.

Yours,
Linus Walleij
