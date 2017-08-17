From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Aug 2017 15:34:09 -0500
Subject: [PATCH 06/11] watchdog: ftwdt010: Extend DT bindings to
 derivatives
In-Reply-To: <20170812184318.10144-7-linus.walleij@linaro.org>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <20170812184318.10144-7-linus.walleij@linaro.org>
Message-ID: <20170817203409.an37wtlbyudmk5io@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 12, 2017 at 08:43:13PM +0200, Linus Walleij wrote:
> This extends the device tree bindings for the Faraday FTWDT010
> block to cover:
> - The "moxa,moxart-watchdog" compatible version
> - The "aspeed,ast2400-wdt" and "aspeed,ast2500-wdt" versions
> - clocks (PCLK non-optional, the Gemini also have this now)
> - reset line (optional, exist on the Gemini)
> - configuration to use the external clock (faraday,use-extclk)
> 
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/watchdog/faraday,ftwdt010.txt    | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
