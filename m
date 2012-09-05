From: olof@lixom.net (Olof Johansson)
Date: Tue, 4 Sep 2012 22:22:21 -0700
Subject: [PATCH] ARM: gemini: fix the gemini build
In-Reply-To: <1346347356-18786-1-git-send-email-linus.walleij@linaro.org>
References: <1346347356-18786-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20120905052221.GG6747@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2012 at 07:22:36PM +0200, Linus Walleij wrote:
> Test-compiling obscure machines I notice that the gemini (which
> by the way lacks a defconfig) is broken since some time back.
> Adding a simple missing include makes it build again.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC guys: please apply this patch directly to the -rc:s
> unless there is some obvious problem with it.

Thanks, applied.

The platform has a listed maintainer (cc:d here) and has had new
development within the last 18 months so it doesn't seem abandoned.


-Olof
