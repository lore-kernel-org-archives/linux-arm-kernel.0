From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 15 Aug 2011 22:06:22 +0900
Subject: [PATCH] backlight: Fix broken regulator API usage in l4f00242t03
In-Reply-To: <20110815064242.GR31404@pengutronix.de>
References: <1313372500-28017-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20110815064242.GR31404@pengutronix.de>
Message-ID: <20110815130619.GB3927@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2011 at 08:42:42AM +0200, Sascha Hauer wrote:

> Maybe you could change these pr_err to dev_err on the way. The rest of
> the driver already uses dev_*.

Minimal diff and all that...
