From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Wed, 1 Dec 2010 08:19:03 +0200
Subject: [PATCH v4] ARM: s3c244x: Fix mess with gpio {set,
	get}_pull callbacks
In-Reply-To: <000d01cb9118$9136c740$b3a455c0$%kim@samsung.com>
References: <201011301701.03443.anarsoul@gmail.com>
	<4CF55785.5090403@metafoo.de>
	<000d01cb9118$9136c740$b3a455c0$%kim@samsung.com>
Message-ID: <201012010819.03728.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 01 December 2010 07:28:17 Kukjin Kim wrote:
> > >  	else if (pup == S3C_GPIO_PULL_NONE)
> 
> pull == S3C_GPIO_PULL_NONE?

Yep, thanks
