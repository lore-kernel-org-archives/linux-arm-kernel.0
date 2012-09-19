From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 19 Sep 2012 07:44:35 -0400
Subject: [PATCH 16/34] ASoC: imx-ssi: remove unneeded mach/hardware.h
 inclusion
In-Reply-To: <201209190801.23616.arnd@arndb.de>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <201209171430.35804.arnd@arndb.de>
 <20120919032337.GU8832@opensource.wolfsonmicro.com>
 <201209190801.23616.arnd@arndb.de>
Message-ID: <20120919114434.GV8832@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 19, 2012 at 08:01:23AM +0000, Arnd Bergmann wrote:
> On Wednesday 19 September 2012, Mark Brown wrote:

> > Hrm, that seems odd - why are we adding platform data to the driver?

> We're not adding it, we just rename the header file from mach/imx.h
> to linux/platform-data/asoc-imx-ssi.h, along with 94 other header files
> that get moved to the same directory.

Ah, that stuff.  I'd not really registered it as actually adding
platform data to be honest, obviously the series was too big to read in
detail.
