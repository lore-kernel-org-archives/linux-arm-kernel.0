From: tony@atomide.com (Tony Lindgren)
Date: Wed, 12 Jun 2013 07:10:50 -0700
Subject: [PATCH 0/3] ARM: OMAP2+: devices: Silence hwmod lookup
 failures (dmic/mcpdm)
In-Reply-To: <1370939520-16132-1-git-send-email-peter.ujfalusi@ti.com>
References: <1370939520-16132-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <20130612141050.GU8164@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [130611 01:37]:
> Hi,
> 
> Small patches to silence the hwmod lookup failures in case when we boot the
> kernel on boards where the IPs are not present (OMAP2/3 vs McPDM, DMIC,
> HDMI audio).

Thanks applying into omap-for-v3.11/fixes-non-critical.

Regards,

Tony

> Peter Ujfalusi (3):
>   ARM: OMAP2+: devices: Do not print error when McPDM hwmod lookup fails
>   ARM: OMAP2+: devices: Do not print error when DMIC hwmod lookup fails
>   ARM: OMAP2+: devices: Do not print error when dss_hdmi hwmod lookup
>     fails
> 
>  arch/arm/mach-omap2/devices.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> -- 
> 1.8.2.1
> 
