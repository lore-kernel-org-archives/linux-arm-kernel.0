From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Tue, 15 Jun 2010 11:47:57 +0100
Subject: [PATCH v3] ISL6271A voltage regulator support.
In-Reply-To: <20100614124831.GE14604@rakim.wolfsonmicro.main>
References: <1276442751-3562-1-git-send-email-marek.vasut@gmail.com>
	<20100614124831.GE14604@rakim.wolfsonmicro.main>
Message-ID: <1276598877.3003.36.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-06-14 at 13:48 +0100, Mark Brown wrote:
> On Sun, Jun 13, 2010 at 05:25:51PM +0200, Marek Vasut wrote:
> > This device is very simple, it supports one buck and two LDOs. The LDOs are
> > fixed-voltage. Only the buck is programable over the I2C bus to 16 possible
> > voltages.
> > 
> > Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 

Applied, although had to manually fix some conflicts with Kconfig.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
