From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Thu, 01 Aug 2013 00:40:56 -0700 (PDT)
Subject: [PATCH v6 2/3] ARM: shmobile: lager: enable Ether
In-Reply-To: <1375175361-23027-3-git-send-email-horms+renesas@verge.net.au>
References: <1375175361-23027-1-git-send-email-horms+renesas@verge.net.au>
 <1375175361-23027-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <87d2px3lkr.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Simon

> @@ -114,6 +138,7 @@ static void __init lager_add_standard_devices(void)
>  	r8a7790_pinmux_init();
>  
>  	r8a7790_add_standard_devices();
> +
>  	platform_device_register_data(&platform_bus, "leds-gpio", -1,
>  				      &lager_leds_pdata,
>  				      sizeof(lager_leds_pdata));
>@@ -125,6 +150,11 @@ static void __init lager_add_standard_devices(void)

I guess above is not needed :)

Except above

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>


Best regards
---
Kuninori Morimoto
