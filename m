From: robh@kernel.org (Rob Herring)
Date: Mon, 20 Mar 2017 11:42:39 -0500
Subject: [PATCH 1/4] irqchip: augment Gemini bindings to reflect Faraday
 origin
In-Reply-To: <20170311231350.15857-1-linus.walleij@linaro.org>
References: <20170311231350.15857-1-linus.walleij@linaro.org>
Message-ID: <20170320164238.2whmughx6nhlpt5b@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 12, 2017 at 12:13:50AM +0100, Linus Walleij wrote:
> When we merged the Gemini interrupt controller it was not yet
> discovered that this IP block is actually a standard Faraday
> Technology interrupt controller.
> 
> As the IP block will probably appear in other designs as well,
> let's augment the DT bindings to reflect that it is first and
> foremost a standard Faraday part with a function name (FTINTC010)
> so that people reusing the IP easily find the driver they need.
> 
> Sorry for the mistakes due to lack of information.
> 
> Greentime Hu <green.hu@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  ...,gemini-interrupt-controller.txt => faraday,ftintc010.txt} | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>  rename Documentation/devicetree/bindings/interrupt-controller/{cortina,gemini-interrupt-controller.txt => faraday,ftintc010.txt} (63%)

Acked-by: Rob Herring <robh@kernel.org>
