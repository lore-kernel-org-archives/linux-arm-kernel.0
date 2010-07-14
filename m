From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 14 Jul 2010 18:42:20 +0900
Subject: [PATCH 2/3] ARM: S5PV210: Aquila: add support for MAX8998 PMIC
In-Reply-To: <20100714083301.GA5933@sirena.org.uk>
References: <1279095416-24871-1-git-send-email-m.szyprowski@samsung.com>
	<1279095416-24871-3-git-send-email-m.szyprowski@samsung.com>
	<20100714083301.GA5933@sirena.org.uk>
Message-ID: <000f01cb2338$de0b14c0$9a213e40$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> On Wed, Jul 14, 2010 at 10:16:55AM +0200, Marek Szyprowski wrote:
> > This patch adds required platform definitions for MAX8998 PMIC driver.
Power
> > regulators for LDO and BUCK outputs has been defined as well as a simple
> > gpio-keys button for power key (to enable wakeup functionality with
> > external interrupt).
> 
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> For the regulator API usage:
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Thanks for your ack.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
