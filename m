From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Thu, 14 Apr 2011 11:51:50 +0300
Subject: [PATCH] ARM: add DT support to the S3C SDI driver
In-Reply-To: <20110413172547.GA27819@dandreoli.com>
References: <20110413172547.GA27819@dandreoli.com>
Message-ID: <201104141151.50497.anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 April 2011 20:25:47 Domenico Andreoli wrote:
> From: Domenico Andreoli <cavokz@gmail.com>
> 
> This patch adds DeviceTree support to the S3C SDI driver.
> 
> It implements all the configurations of the platform driver except the
> set_power() callback and the ocr_avail mask.
> 
> Signed-off-by: Domenico Andreoli <cavokz@gmail.com>

Hm, but is there any bootloader with dt support for s3c24xx?

Regards
Vasily
