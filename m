From: tony@atomide.com (Tony Lindgren)
Date: Mon, 10 Apr 2017 09:29:12 -0700
Subject: [PATCH] ARM: omap2plus_defconfig: Enable droid 4 devices
In-Reply-To: <20170409232840.19927-1-tony@atomide.com>
References: <20170409232840.19927-1-tony@atomide.com>
Message-ID: <20170410162911.GE5339@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [170409 16:31]:
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
...
> +CONFIG_CHARGER_CPCAP=m
...
> +CONFIG_PHY_CPCAP_USB=m

I'm dropping these two changes from this patch as they are not
in Linux next.

Regards,

Tony
