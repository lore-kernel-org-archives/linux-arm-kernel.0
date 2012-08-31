From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 31 Aug 2012 09:39:26 +0800
Subject: [PATCH v4 7/7] mfd: anatop-mfd: remove anatop driver
In-Reply-To: <1346237818-9498-8-git-send-email-b29396@freescale.com>
References: <1346237818-9498-1-git-send-email-b29396@freescale.com>
 <1346237818-9498-8-git-send-email-b29396@freescale.com>
Message-ID: <20120831013924.GB7726@r65073-Latitude-D630>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2012 at 06:56:58PM +0800, Dong Aisheng wrote:
> -config MFD_ANATOP
> -	bool "Support for Freescale i.MX on-chip ANATOP controller"
> -	depends on SOC_IMX6Q
> -	help
> -	  Select this option to enable Freescale i.MX on-chip ANATOP
> -	  MFD controller. This controller embeds regulator and
> -	  thermal devices for Freescale i.MX platforms.
> -

All the occurrences of MFD_ANATOP should be removed too.  I know there
is one in arch/arm/mach-imx/Kconfig.

Regards,
Shawn
