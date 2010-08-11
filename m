From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 11 Aug 2010 22:03:11 +0100
Subject: [PATCH v3 9/9] omap: zoom: add mmc3/wl1271 device support
In-Reply-To: <AANLkTi=n=uH5ePRf8KzXWTtSdyRabpOCOgLBSD1GfwkJ@mail.gmail.com>
References: <1281478348-24833-1-git-send-email-ohad@wizery.com>
	<1281478348-24833-10-git-send-email-ohad@wizery.com>
	<4C626140.3080107@nokia.com>
	<AANLkTik8yftwy9Toq473134vcdoFN1Z29oTc9MGEUzue@mail.gmail.com>
	<AANLkTi=n=uH5ePRf8KzXWTtSdyRabpOCOgLBSD1GfwkJ@mail.gmail.com>
Message-ID: <20100811210311.GA10207@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 12, 2010 at 01:39:38AM +0530, kishore kadiyala wrote:

> If the LDO is fixed voltage source from TWL then since regulator
> framework supports only adjustable LDO's, I think you can

The regulator framework supports fixed voltage regulators just fine.
