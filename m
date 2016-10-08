From: Rob Herring <robh@kernel.org>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: linus.walleij at linaro.org, gnurou at gmail.com, linux-gpio at vger.kernel.org,
	linux-arm-kernel at lists.infradead.org, linux-kernel at vger.kernel.org,
	linux-oxnas at lists.tuxfamily.org, devicetree at vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: oxnas: Update Pinctrl and GPIO for
 OX820 Support
Message-ID: <20161008232940.GA19861@rob-hp-laptop>
References: <20161004134148.23028-1-narmstrong@baylibre.com>
 <20161004134148.23028-4-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161004134148.23028-4-narmstrong@baylibre.com>
Date: Sat, 8 Oct 2016 18:29:42 -0500
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 04, 2016 at 03:41:48PM +0200, Neil Armstrong wrote:
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  Documentation/devicetree/bindings/gpio/gpio_oxnas.txt       | 2 +-
>  Documentation/devicetree/bindings/pinctrl/oxnas,pinctrl.txt | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt b/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
> index 928ed4f..9665147 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
> @@ -3,7 +3,7 @@
>  Please refer to gpio.txt for generic information regarding GPIO bindings.
>  
>  Required properties:
> - - compatible: "oxsemi,ox810se-gpio"
> + - compatible: "oxsemi,ox810se-gpio" or "oxsemi,ox820-gpio"

It is preferred to have one per line, but it's fine unless you respin 
the series.

Acked-by: Rob Herring <robh@kernel.org>
