From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 Nov 2017 16:51:23 +0100
Subject: [PATCH 2/2] pinctrl: sunxi: Disable strict mode for H5 driver
In-Reply-To: <20171125120200.23294-3-andre.przywara@arm.com>
References: <20171125120200.23294-1-andre.przywara@arm.com>
 <20171125120200.23294-3-andre.przywara@arm.com>
Message-ID: <CACRpkdZX5U=JoQFS+X96+F68yVSZbnCZpgNfAnvfJGxZ9moi8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 25, 2017 at 1:02 PM, Andre Przywara <andre.przywara@arm.com> wrote:

> All of the H5 boards in the kernel reference the MMC0 CD pin twice in
> their DT, so strict mode will make the MMC driver fail to load.
> To keep existing DTs working, disable strict mode in the H5 driver.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reported-by: Chris Obbard <obbardc@gmail.com>

Patch applied with Maxime's ACK.

Yours,
Linus Walleij
