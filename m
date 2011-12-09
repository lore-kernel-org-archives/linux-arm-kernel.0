From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 9 Dec 2011 10:26:31 +0100
Subject: [PATCH] arm/imx: fix cpufreq build error
In-Reply-To: <1323399055-31850-1-git-send-email-shawn.guo@linaro.org>
References: <20111209020948.GA28216@b20223-02.ap.freescale.net>
 <1323399055-31850-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20111209092631.GB3327@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2011 at 10:50:55AM +0800, Shawn Guo wrote:
> This patch adds missing linux/module.h to fix the build error seen
> on imx cpuidle driver.
> 
>   CC      arch/arm/plat-mxc/cpufreq.o
> arch/arm/plat-mxc/cpufreq.c:203: error: expected declaration specifiers or '...' before string constant
> arch/arm/plat-mxc/cpufreq.c:203: warning: data definition has no type or storage class
> arch/arm/plat-mxc/cpufreq.c:203: warning: type defaults to 'int' in declaration of 'MODULE_AUTHOR'
> arch/arm/plat-mxc/cpufreq.c:203: warning: function declaration isn't a prototype
> arch/arm/plat-mxc/cpufreq.c:204: error: expected declaration specifiers or '...' before string constant
> arch/arm/plat-mxc/cpufreq.c:204: warning: data definition has no type or storage class
> arch/arm/plat-mxc/cpufreq.c:204: warning: type defaults to 'int' in declaration of 'MODULE_DESCRIPTION'
> arch/arm/plat-mxc/cpufreq.c:204: warning: function declaration isn't a prototype
> arch/arm/plat-mxc/cpufreq.c:205: error: expected declaration specifiers or '...' before string constant
> arch/arm/plat-mxc/cpufreq.c:205: warning: data definition has no type or storage class
> arch/arm/plat-mxc/cpufreq.c:205: warning: type defaults to 'int' in declaration of 'MODULE_LICENSE'
> arch/arm/plat-mxc/cpufreq.c:205: warning: function declaration isn't a prototype
> make[1]: *** [arch/arm/plat-mxc/cpufreq.o] Error 1
> make: *** [arch/arm/plat-mxc] Error 2
> 
> Reported-by: Richard Zhao <richard.zhao@freescale.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111209/3419e3cd/attachment.sig>
