From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 17 Nov 2010 13:31:37 +0000
Subject: [PATCH v5 04/12] spi: add ti-ssp spi master driver
In-Reply-To: <4CE31F0E.7050103@ti.com>
References: <1289848334-8695-1-git-send-email-cyril@ti.com>
	<1289848334-8695-5-git-send-email-cyril@ti.com>
	<20101116072225.GF4074@angua.secretlab.ca>
	<AANLkTi=utWumLKo9QVWXpkC8WxpgaNJJs+dj=pa2eq-q@mail.gmail.com>
	<4CE31F0E.7050103@ti.com>
Message-ID: <20101117133136.GA19488@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 16, 2010 at 07:17:18PM -0500, Cyril Chemparathy wrote:

> The ability to wait on multiple devices may come handy.  In this

This is essential for any helpers, otherwise we can't cope easily with
mixes of GPIO and power or with regulators from multiple chips (like an
extra DCDC, for example).
