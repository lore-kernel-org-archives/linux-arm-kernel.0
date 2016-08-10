From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Aug 2016 22:43:31 +0200
Subject: [PATCH 1/2] ARM: dts: add syscon compatible string for AP syscon
In-Reply-To: <1470821892-25957-1-git-send-email-linus.walleij@linaro.org>
References: <1470821892-25957-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <3579523.XSFLhNYcm2@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, August 10, 2016 11:38:12 AM CEST Linus Walleij wrote:
> This syscon needs to be looked up by clocks, flash protection
> and other consumers.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: please apply this directly to fixes so we have
> functional flash protection on the Integrator/AP.
> 

Applied both to fixes, thanks!

	Arnd
