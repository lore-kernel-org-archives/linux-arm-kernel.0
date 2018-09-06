From: olof@lixom.net (Olof Johansson)
Date: Thu, 6 Sep 2018 10:02:40 -0700
Subject: [PATCH] ARM: u300: Delete dummy SPI chip
In-Reply-To: <20180905091828.30170-1-linus.walleij@linaro.org>
References: <20180905091828.30170-1-linus.walleij@linaro.org>
Message-ID: <20180906170240.ktxfu6nfouezz6v2@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2018 at 11:18:28AM +0200, Linus Walleij wrote:
> It's been told to me a few times that this kernel module
> should not exist, instead we should use the loopback test
> from userspace if need be. If a kernel module is required
> for testing SPI, it should be generic and put in
> drivers/spi/*.
> 
> Delete this driver.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: please apply this directly to the ARM SoC
> tree, I do not intend to send any more U300 related patches
> this kernel cycle.

Applied to next/soc. Thanks!


-Olof
