From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Aug 2017 15:32:53 -0500
Subject: [PATCH 01/11] watchdog: gemini/ftwdt010: rename DT bindings
In-Reply-To: <20170812184318.10144-2-linus.walleij@linaro.org>
References: <20170812184318.10144-1-linus.walleij@linaro.org>
 <20170812184318.10144-2-linus.walleij@linaro.org>
Message-ID: <20170817203253.y53qxyfiixas5a5q@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 12, 2017 at 08:43:08PM +0200, Linus Walleij wrote:
> The device tree bindings are in two copies and also should be
> consolidated into a single Faraday Technology FTWDT010
> binding since we uncovered that this IP part is a standard
> IP from Faraday.
> 
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/watchdog/cortina,gemini-watchdog.txt       | 17 -----------------
>  ...{cortina,gemin-watchdog.txt => faraday,ftwdt010.txt} | 11 ++++++++---
>  2 files changed, 8 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/cortina,gemini-watchdog.txt
>  rename Documentation/devicetree/bindings/watchdog/{cortina,gemin-watchdog.txt => faraday,ftwdt010.txt} (55%)

Acked-by: Rob Herring <robh@kernel.org>
