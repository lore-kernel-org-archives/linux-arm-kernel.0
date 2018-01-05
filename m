From: olof@lixom.net (Olof Johansson)
Date: Thu, 4 Jan 2018 23:34:47 -0800
Subject: [PATCH] ARM: dts: Delete bogus reference to the charlcd
In-Reply-To: <20180102075717.7374-1-linus.walleij@linaro.org>
References: <20180102075717.7374-1-linus.walleij@linaro.org>
Message-ID: <20180105073447.dfhr2czrlhiutlq7@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 02, 2018 at 08:57:17AM +0100, Linus Walleij wrote:
> The EB MP board probably has a character LCD but the board manual does
> not really state which IRQ it has assigned to this device. The invalid
> assignment was a mistake by me during submission of the DTSI where I was
> looking for the reference, didn't find it and didn't fill it in.
> 
> Delete this for now: it can probably be fixed but that requires access
> to the actual board for some trial-and-error experiments.
> 
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: please apply this directly for next to fix the DTS
> compiler noise it is generating.

Applied, thanks.


-Olof
