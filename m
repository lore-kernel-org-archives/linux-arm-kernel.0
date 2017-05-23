From: robh@kernel.org (Rob Herring)
Date: Mon, 22 May 2017 19:51:19 -0500
Subject: [PATCH 2/8] clocksource/drivers/fttmr010: Merge FTTMR010 DT
 bindings
In-Reply-To: <20170517140542.20016-3-linus.walleij@linaro.org>
References: <20170517140542.20016-1-linus.walleij@linaro.org>
 <20170517140542.20016-3-linus.walleij@linaro.org>
Message-ID: <20170523005119.wkfvs5qnwhmr62bd@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 17, 2017 at 04:05:36PM +0200, Linus Walleij wrote:
> This merges the Moxa and FTTMR010 device tree bindings into the
> Faraday binding document to avoid confusion.
> 
> The FTTMR010 is the IP block used by these SoCs, in vanilla
> or modified variant.
> 
> The Aspeed variant is modified such that it is no longer fully
> register-compatible with FTTMR010 so for this reason it is not
> listed with two compatible strings, instead just one.
> 
> Cc: devicetree at vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Jonas Jensen <jonas.jensen@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/timer/faraday,fttmr010.txt    |  4 +++-
>  .../devicetree/bindings/timer/moxa,moxart-timer.txt   | 19 -------------------
>  2 files changed, 3 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/moxa,moxart-timer.txt

Acked-by: Rob Herring <robh@kernel.org> 
