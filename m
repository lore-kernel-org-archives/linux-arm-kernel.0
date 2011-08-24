From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 24 Aug 2011 18:33:32 +0200
Subject: [[PATCH v2 0/6] imx soc revision clean up
In-Reply-To: <1314162277-2840-1-git-send-email-jason.hui@linaro.org>
References: <1314162277-2840-1-git-send-email-jason.hui@linaro.org>
Message-ID: <20110824163332.GJ31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 01:04:31PM +0800, Jason Liu wrote:
> The patchset make some clean up for the imx soc revision display by
> - introudce the generic function for displaying silicon revision
> - update the imx SoCs to adopt the same usage
> 
> The patchset is based on Fabio's initial commit and I did some update
> 
> V2: Address comments from Sascha
> - Remove the EXPORT_SYMBOL from imx_print_silicon_rev
> - Fix the mx31 print twice issue
> 
> Fabio Estevam (1):
>   ARM: imx: Introduce generic function for displaying silicon revision
> 
> Jason Liu (5):
>   ARM: mx25: Print silicon revision on boot
>   ARM: mx27: Print silicon revision on boot
>   ARM: mx31: use generic function for displaying silicon revision
>   ARM: mx35: use generic function for displaying silicon revision
>   ARM: mx5: use generic function for displaying silicon revision

Applied for next.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
