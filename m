From: silvio.fricke@gmail.com (S. Fricke)
Date: Wed, 18 Jun 2014 20:42:34 +0200
Subject: [PATCH v11 2/8] ASoC: core: Generic ac97 link reset functions
In-Reply-To: <1376924761-4054-3-git-send-email-mpa@pengutronix.de>
References: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
 <1376924761-4054-3-git-send-email-mpa@pengutronix.de>
Message-ID: <20140618184234.GA27312@sfrouter>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Markus,

I'm fighting with your ac97 pinctrl configuration per dts. 

> [...]
> +ssi {
> +	...
> +
> +	pinctrl-names = "default", "ac97-running", "ac97-reset", "ac97-warm-reset";
> +	pinctrl-0 = <&ac97link_running>;
> +	pinctrl-1 = <&ac97link_running>;
> +	pinctrl-2 = <&ac97link_reset>;
> +	pinctrl-3 = <&ac97link_warm_reset>;
> +	ac97-gpios = <&gpio3 20 0 &gpio3 22 0 &gpio3 28 0>;

I see here the gpios for sync, sdata and reset. On my board I have two sdata
lines (sdata-in and sdata-out) which line should I specify here for this setting?

Thanks for a short answer and
Cheers, Silvio


-- 
-- S. Fricke ---------------------------------------- silvio at port1024.net --
