From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 15 May 2012 20:21:39 +0800
Subject: [PATCH 2/2] ARM: imx: add initial imx6dl-sabreai board support
In-Reply-To: <1337084041-19436-1-git-send-email-shawn.guo@linaro.org>
References: <1337084041-19436-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120515122138.GH20367@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 08:14:01PM +0800, Shawn Guo wrote:
>  dtb-$(CONFIG_SOC_IMX6Q)	+= imx6q-arm2.dtb \
>  			   imx6q-sabrelite.dtb \
>  			   imx6q-sabresd.dtb \
> +			   imx6q-sabreai.dtb \

It should be imx6dl-sabreai.dtb.

-- 
Regards,
Shawn
