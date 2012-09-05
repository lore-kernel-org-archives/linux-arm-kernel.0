From: tony@atomide.com (Tony Lindgren)
Date: Wed, 5 Sep 2012 16:27:32 -0700
Subject: [PATCH v8 1/3] ARM: OMAP2/3: hwmod data: add gpmc
In-Reply-To: <17b686d1aaf6fa6bfdbe30993804dd5a269ae6db.1346846464.git.afzal@ti.com>
References: <cover.1346846464.git.afzal@ti.com>
 <17b686d1aaf6fa6bfdbe30993804dd5a269ae6db.1346846464.git.afzal@ti.com>
Message-ID: <20120905232732.GM1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Afzal Mohammed <afzal@ti.com> [120905 05:38]:
> Add gpmc hwmod and associated interconnect data
>  
> +static struct omap_hwmod_addr_space omap2420_gpmc_addrs[] = {
> +	{
> +		.pa_start	= 0x6800A000,
> +		.pa_end		= 0x6800AFFF,
> +		.flags		= ADDR_TYPE_RT
> +	},
> +	{ }
> +};

Nit, please lowercase all the hex numbers, that's the standard
in Linux.

Tony
