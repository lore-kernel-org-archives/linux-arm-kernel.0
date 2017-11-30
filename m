From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 30 Nov 2017 11:53:16 +0100
Subject: [PATCH] rtc: add mxc driver for i.MX53
In-Reply-To: <20171130095047.4sl7rfa5cc6rtmig@pengutronix.de>
References: <20171128073927.12035-1-linux-kernel-dev@beckhoff.com>
 <20171130095047.4sl7rfa5cc6rtmig@pengutronix.de>
Message-ID: <20171130115316.1dcd86d8@karo-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 30 Nov 2017 10:50:47 +0100 Sascha Hauer wrote:
> On Tue, Nov 28, 2017 at 08:39:27AM +0100, linux-kernel-dev at beckhoff.com wrote:
[...]
> > +/*! MXC RTC Power management control */
> > +static int mxc_rtc_probe(struct platform_device *pdev)
> > +{
> > +	struct timespec tv;
> > +	struct resource *res;
> > +	struct rtc_drv_data *pdata = NULL;
> 
> No need to initialize.
> 
> > +	void __iomem *ioaddr;
> > +	int ret = 0;
>
Same here.


Lothar Wa?mann
