From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 14 Oct 2010 07:55:40 +0900
Subject: [PATCH 2.6.36] S3C64XX: Fix special function for IISv4 port
In-Reply-To: <20101013194256.GA20533@rakim.wolfsonmicro.main>
References: <1286998603-20401-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20101013194256.GA20533@rakim.wolfsonmicro.main>
Message-ID: <003201cb6b29$c40404e0$4c0c0ea0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> On Wed, Oct 13, 2010 at 08:36:43PM +0100, Mark Brown wrote:
> > When converting to use s3c_gpio_cfgpin_range() the function for the
> > IISv4 block appears to have been typoed as 4 (the keypad) rather than
> > 5 as it should be.
> 
> Sorry about the 2.6.36 in the subject line - this actually only applies
> to -next.

No problem ;-)
Thanks for your fixing.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
