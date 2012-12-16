From: olof@lixom.net (Olof Johansson)
Date: Sat, 15 Dec 2012 22:24:50 -0800
Subject: [PATCH] ARM: u300: delete custom pin hog code
In-Reply-To: <1355494622-26022-1-git-send-email-linus.walleij@stericsson.com>
References: <1355494622-26022-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20121216062450.GB15467@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 14, 2012 at 03:17:02PM +0100, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> With recent changes in the kernel, the MMCI and PL011 UART
> drivers will autonomously request their pins to be muxed in,
> so this machine-specific pin hogging code is just interfering
> with the proper mechanism and causing regressions in the v3.8
> kernel. Delete it and the problems go away.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi ARM SoC guys: please line up this one U300 patch for the
> ARM fixes during/following the v3.8 merge window.

Applied, thanks.


-Olof
