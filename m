From: tony@atomide.com (Tony Lindgren)
Date: Fri, 25 Jan 2013 09:09:03 -0800
Subject: [PATCH v2 5/5] wlcore: move wl12xx_platform_data up and make
 it truly optional
In-Reply-To: <1359108334-18459-1-git-send-email-coelho@ti.com>
References: <1358952038-5982-6-git-send-email-coelho@ti.com>
 <1359108334-18459-1-git-send-email-coelho@ti.com>
Message-ID: <20130125170903.GZ22517@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Luciano Coelho <coelho@ti.com> [130125 02:09]:
> The platform data is used not only by wlcore-based drivers, but also
> by wl1251.  Move it up in the directory hierarchy to reflect this.
> 
> Additionally, make it truly optional.  At the moment, disabling
> platform data while wl1251_sdio or wlcore_sdio are enabled doesn't
> work, but it will be necessary when device tree support is
> implemented.
> 
> Signed-off-by: Luciano Coelho <coelho@ti.com>
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> In v2:
>    * Fix ti/Makefile
>    * Modify board_omap3evm.c which was still using the old Kconfig define
> 
> Tony, is it okay if I add this change in the omap3evm board in this
> patch and queue it via wireless so that the whole thing is in sync?

OK, this should not cause additional merge conflicts:

Acked-by: Tony Lindgren <tony@atomide.com> 
