From: olof@lixom.net (Olof Johansson)
Date: Sun, 11 Jan 2015 13:06:11 -0800
Subject: [PATCH] ARM: nomadik: fix up leftover device tree pins
In-Reply-To: <1420830680-18611-1-git-send-email-linus.walleij@linaro.org>
References: <1420830680-18611-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20150111210611.GA25777@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 08:11:20PM +0100, Linus Walleij wrote:
> We altered the device tree bindings for the Nomadik family of
> pin controllers to be standard, this file was merged out-of-order
> so we missed fixing this. Fix it up.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC guys: please pick this directly for fixes, I have no
> other Nomadik fixes for this merge window AFAIK.

Thanks, applied to fixes.


-Olof
