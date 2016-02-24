From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Feb 2016 15:51:10 +0100
Subject: [PATCH] ARM: realview: add EB syscon variants to bindings
In-Reply-To: <1456218606-3749-1-git-send-email-linus.walleij@linaro.org>
References: <1456218606-3749-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <3716654.ki0irAFpjQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 February 2016 10:10:06 Linus Walleij wrote:
> There are two distinct RealView EB system controller that we need
> to detect and handle because their register layout differ
> slightly.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 

Looks ok.

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
