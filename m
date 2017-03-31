From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 Mar 2017 12:00:20 +0200
Subject: [PATCH] ARM: dts: augment Moxa ART GPIO node
In-Reply-To: <20170322111209.14571-1-linus.walleij@linaro.org>
References: <20170322111209.14571-1-linus.walleij@linaro.org>
Message-ID: <CAK8P3a0ZBYZTc+5ty9SUmU3Lb-vvd7Dcco+Hai7yH_khyfbB-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 12:12 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> The Moxa ART GPIO is a Faraday FTGPIO010. Augment the DTS node
> to indicate both compatible values for the SoC and the IP part.
> Also increase the register range to 0x100, it has at least 0x48
> bytes of registers, and a few extra will not hurt.
>
> Tested-by: Jonas Jensen <jonas.jensen@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: please just apply this to DT for-next like the
> other Moxa Faraday cleanup patch.

Applied on next/dt, thanks!
