From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 3 May 2011 19:04:48 -0600
Subject: [PATCH] ARM: add DT support to the S3C SDI driver
In-Reply-To: <201104141151.50497.anarsoul@gmail.com>
References: <20110413172547.GA27819@dandreoli.com>
	<201104141151.50497.anarsoul@gmail.com>
Message-ID: <20110504010448.GA4952@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2011 at 11:51:50AM +0300, Vasily Khoruzhick wrote:
> On Wednesday 13 April 2011 20:25:47 Domenico Andreoli wrote:
> > From: Domenico Andreoli <cavokz@gmail.com>
> > 
> > This patch adds DeviceTree support to the S3C SDI driver.
> > 
> > It implements all the configurations of the platform driver except the
> > set_power() callback and the ocr_avail mask.
> > 
> > Signed-off-by: Domenico Andreoli <cavokz@gmail.com>
> 
> Hm, but is there any bootloader with dt support for s3c24xx?

On current u-boot mainline, all arm platforms can now add devicetree
support by enabling CONFIG_OF_LIBFDT.

g.
