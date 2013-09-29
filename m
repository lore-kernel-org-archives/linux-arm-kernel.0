From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 29 Sep 2013 15:35:30 +0800
Subject: [v1] ahci: imx: setup power saving methods
In-Reply-To: <20130927131441.GA3205@htj.dyndns.org>
References: <1380269265-10821-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1380269265-10821-2-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20130927131441.GA3205@htj.dyndns.org>
Message-ID: <20130929073528.GE26156@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 09:14:41AM -0400, Tejun Heo wrote:
> Hello,
> 
> On Fri, Sep 27, 2013 at 04:07:45PM +0800, Richard Zhu wrote:
> > +config AHCI_IMX_PHY_POWER_DOWN_MODE
> > +	bool "Power saving mode when there is no SATA DEV detected on the port"
> > +	depends on AHCI_IMX
> > +	help
> > +	  This option enable the power down mode of the imx ahci when there is
> > +	  no sata device detected on the port, the sata port wouldn't be
> > +	  functional anymore except one system power down, and power up again.
> 
> The last part of the sentence is a bit difficult to understand.  Also,
> I'm not sure whether making this a build option is a good idea.

Agreed.  Why do not we support this unconditionally?

Shawn
