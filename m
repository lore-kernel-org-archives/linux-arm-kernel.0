From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 01 Dec 2010 20:28:22 +0900
Subject: [PATCH 1/3] ARM: SAMSUNG: Convert s3c_irqext_wake() to new irq_
	interrupt methods
In-Reply-To: <1290698309-7691-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1290698309-7691-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <002f01cb914a$de3e3fa0$9ababee0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> Kernel 2.6.37 adds new interrupt methods which take a struct irq_data
> rather than an irq number. Begin converting Samsung platforms over to
> these methods by converting s3c_irqext_wake() with a simple textual
> substitution.

And...as you know, need to convert s3c_irq_wake() to new irq_ interrupt
method also.
Ok...I will do it or will check Lennert Buytenhek's patch for it :-)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
