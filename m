From: joel@jms.id.au (Joel Stanley)
Date: Tue, 13 Sep 2016 22:11:29 +0930
Subject: [PATCH v3 4/7] palmetto: Request relevant mux functions in
 devicetree
In-Reply-To: <20160830075600.11559-5-andrew@aj.id.au>
References: <20160830075600.11559-1-andrew@aj.id.au>
 <20160830075600.11559-5-andrew@aj.id.au>
Message-ID: <CACPK8Xe-dowcwXkO8rDH2reMzGadUMSq5ZtV=23FP4virt+DUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 30, 2016 at 5:25 PM, Andrew Jeffery <andrew@aj.id.au> wrote:
> +&pinctrl {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_flbusy_default &pinctrl_flwp_default
> +                       &pinctrl_vgahs_default &pinctrl_vgavs_default
> +                       &pinctrl_ddcclk_default &pinctrl_ddcdat_default
> +
> +                       &pinctrl_pwm1_default &pinctrl_pwm2_default
> +                       &pinctrl_pwm3_default &pinctrl_pwm4_default
> +                       &pinctrl_pwm5_default &pinctrl_pwm6_default
> +                       &pinctrl_pwm7_default
> +
> +                       &pinctrl_bmcint_default &pinctrl_flack_default>;
> +};

It's not clear that all systems use these pins in that way. I will not
include this one for now.

Cheers,

Joel
