From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 27 Nov 2013 11:53:10 -0800
Subject: [PATCH] clk: fixed-factor: Fix device-tree binding typo
In-Reply-To: <1380136218-15578-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1380136218-15578-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20131127195310.16819.83218@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ezequiel Garcia (2013-09-25 12:10:18)
> The required properties are not named "div" and "mult",
> but rather "clock-div" and "clock-mult".
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Taken into clk-next.

Thanks,
Mike

> ---
>  Documentation/devicetree/bindings/clock/fixed-factor-clock.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/fixed-factor-clock.txt b/Documentation/devicetree/bindings/clock/fixed-factor-clock.txt
> index 5757f9a..1bae8527 100644
> --- a/Documentation/devicetree/bindings/clock/fixed-factor-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/fixed-factor-clock.txt
> @@ -19,6 +19,6 @@ Example:
>                 compatible = "fixed-factor-clock";
>                 clocks = <&parentclk>;
>                 #clock-cells = <0>;
> -               div = <2>;
> -               mult = <1>;
> +               clock-div = <2>;
> +               clock-mult = <1>;
>         };
> -- 
> 1.8.1.5
