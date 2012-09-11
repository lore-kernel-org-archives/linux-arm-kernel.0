From: afzal@ti.com (Mohammed, Afzal)
Date: Tue, 11 Sep 2012 10:16:56 +0000
Subject: [PATCH v8 2/3] ARM: OMAP2+: gpmc: Adapt to HWMOD
In-Reply-To: <5047AE2B.30807@ti.com>
References: <cover.1346846464.git.afzal@ti.com>
 <c14607ff57fca419dc9d7e0beaea197e001f4e25.1346846464.git.afzal@ti.com>
 <5047AE2B.30807@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9E1D2C@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Thu, Sep 06, 2012 at 01:25:23, Hunter, Jon wrote:

> Nit-pick, I see some devices writing the above as ...
> 
> 	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);
> 
>  	return IS_ERR(pdev) ? PTR_ERR(pdev) : 0;

> Otherwise ...
> 
> Reviewed-by: Jon Hunter <jon-hunter@ti.com>

Thanks for your reviews, updated series has been posted

Regards
Afzal
