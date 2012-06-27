From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 27 Jun 2012 14:30:22 +0800
Subject: [PATCH v7 05/14] USB: Chipidea: rename struct ci13xxx_udc_driver
 to struct ci13xxx_platform_data
In-Reply-To: <201206262354.03543.marex@denx.de>
References: <1340607391-16380-1-git-send-email-richard.zhao@freescale.com>
 <1340607391-16380-6-git-send-email-richard.zhao@freescale.com>
 <201206262354.03543.marex@denx.de>
Message-ID: <20120627063021.GD21750@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2012 at 11:54:03PM +0200, Marek Vasut wrote:
> Dear Richard Zhao,
> 
> > This patch rename struct ci13xxx_udc_driver and var with the type.
> > 
> > ci13xxx_platform_data reflect it's passed from platfrom driver.
> 
> Maybe rather driver data? As platform_data has certain different conotation to 
> it.
I prefer the current way. driver data is something that is allocated
and managed internally by the driver.

Thanks
Richard
