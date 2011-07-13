From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 13 Jul 2011 21:46:52 +0900
Subject: [PATCH V2 03/10] ASoc: mxs: add mxs-sgtl5000 machine driver
In-Reply-To: <20110713115711.GG1928@pengutronix.de>
References: <1310483085-31442-1-git-send-email-b29396@freescale.com>
	<1310483085-31442-4-git-send-email-b29396@freescale.com>
	<20110713115711.GG1928@pengutronix.de>
Message-ID: <20110713124648.GA6640@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2011 at 01:57:11PM +0200, Wolfram Sang wrote:

> Proper regulator support for mxs is not in mainline yet. Is that
> planned? How do you do it?

Regulator support is not a feature of the platform, it's a generic Linux
feature.
