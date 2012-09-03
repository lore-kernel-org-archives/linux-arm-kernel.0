From: b29396@freescale.com (Dong Aisheng)
Date: Mon, 3 Sep 2012 10:34:14 +0800
Subject: [PATCH v4 7/7] mfd: anatop-mfd: remove anatop driver
In-Reply-To: <20120831013924.GB7726@r65073-Latitude-D630>
References: <1346237818-9498-1-git-send-email-b29396@freescale.com>
 <1346237818-9498-8-git-send-email-b29396@freescale.com>
 <20120831013924.GB7726@r65073-Latitude-D630>
Message-ID: <20120903023414.GB11891@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2012 at 09:39:26AM +0800, Shawn Guo wrote:
> On Wed, Aug 29, 2012 at 06:56:58PM +0800, Dong Aisheng wrote:
> > -config MFD_ANATOP
> > -	bool "Support for Freescale i.MX on-chip ANATOP controller"
> > -	depends on SOC_IMX6Q
> > -	help
> > -	  Select this option to enable Freescale i.MX on-chip ANATOP
> > -	  MFD controller. This controller embeds regulator and
> > -	  thermal devices for Freescale i.MX platforms.
> > -
> 
> All the occurrences of MFD_ANATOP should be removed too.  I know there
> is one in arch/arm/mach-imx/Kconfig.
> 
Yes, it has been made in patch 5:
[PATCH v4 5/7] ARM: imx6q: convert to use syscon to access anatop registers

Regards
Dong Aisheng
