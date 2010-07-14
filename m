From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 14 Jul 2010 09:33:01 +0100
Subject: [PATCH 2/3] ARM: S5PV210: Aquila: add support for MAX8998 PMIC
In-Reply-To: <1279095416-24871-3-git-send-email-m.szyprowski@samsung.com>
References: <1279095416-24871-1-git-send-email-m.szyprowski@samsung.com>
	<1279095416-24871-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20100714083301.GA5933@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 14, 2010 at 10:16:55AM +0200, Marek Szyprowski wrote:
> This patch adds required platform definitions for MAX8998 PMIC driver. Power
> regulators for LDO and BUCK outputs has been defined as well as a simple
> gpio-keys button for power key (to enable wakeup functionality with
> external interrupt).

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

For the regulator API usage:

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
