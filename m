From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Oct 2012 15:40:44 -0700
Subject: [PATCH 10/10] document: devicetree: bind pinconf in pinctrl single
In-Reply-To: <1350551224-12857-10-git-send-email-haojian.zhuang@gmail.com>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
 <1350551224-12857-10-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <20121019224044.GV4730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Haojian Zhuang <haojian.zhuang@gmail.com> [121018 02:09]:
> Add comments with pinconf & gpio range in the document of
> pinctrl-single.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
> ---
>  .../devicetree/bindings/pinctrl/pinctrl-single.txt |   43 ++++++++++++++++++++
>  1 files changed, 43 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
> index 5187f0d..b0e5059 100644
> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
> @@ -15,6 +15,49 @@ Optional properties:
>    available and same for all registers; if not specified, disabling of
>    pin functions is ignored
>  
> +- pinctrl-single,gpio-mask : mask of enabling gpio function register
> +
> +- pinctrl-single,gpio-ranges : gpio range list
> +
> +- pinctrl-single,gpio : array with gpio range start, size & register
> +  offset
> +
> +- pinctrl-single,gpio-enable : value of enabling gpio function
> +
> +- pinctrl-single,gpio-disable : value of disabling gpio function
> +
> +- pinctrl-single,power-source-mask : mask of setting power source in
> +  the pinmux register
> +
> +- pinctrl-single,power-source-shift : shift of power source field in
> +  the pinmux register

Maybe use "value of", "mask for", "shift for" here?
Can somebody native english speaker maybe comment on that?

Regards,

Tony
