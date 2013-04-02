From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 01 Apr 2013 17:17:38 -0700 (PDT)
Subject: [PATCH 1/2] ARM: shmobile: R8A7779: add Ether support
In-Reply-To: <201304020204.54546.sergei.shtylyov@cogentembedded.com>
References: <201304020204.54546.sergei.shtylyov@cogentembedded.com>
Message-ID: <87y5d16b1d.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Sergei

> +void __init r8a7779_add_ether_device(void *pdata)
> +{
> +	ether_device.dev.platform_data = pdata;
> +
> +	platform_device_register(&ether_device);
> +}

Current ARM SoC is trying to not use platform_device_register()
Please use platform_device_register_xxx()
Same comment for [2/2]

Best regards
---
Kuninori Morimoto
