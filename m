From: tony@atomide.com (Tony Lindgren)
Date: Mon, 30 Nov 2015 11:51:23 -0800
Subject: [PATCH v2 1/6] ARM: OMAP2+: dts: cm-t335: add initial support
In-Reply-To: <1448373733-5839-2-git-send-email-uri.mashiach@compulab.co.il>
References: <1445948100-16446-1-git-send-email-uri.mashiach@compulab.co.il>
 <1448373733-5839-1-git-send-email-uri.mashiach@compulab.co.il>
 <1448373733-5839-2-git-send-email-uri.mashiach@compulab.co.il>
Message-ID: <20151130195123.GP2517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Uri Mashiach <uri.mashiach@compulab.co.il> [151124 06:03]:
> --- /dev/null
> +++ b/arch/arm/boot/dts/am335x-cm-t335.dts
...

> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_pins>;
> +
> +	status = "okay";
> +};
> +

FYI, the extra line break at the end of the file causes whitespace
warnings when applying. And fixing that causes extra hassles with
applying the other patches in the series as the patches won't apply..
So for the next time, you may want to check that ;)

Also, the subject line should be "ARM: dts: ..." for the dts changes
so the git log loooks unified for all the ARM SoCs.

Anyways, I've fixed up those locally and applying into omap-for-v4.5/dt.

Regards,

Tony
