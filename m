From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 22 Nov 2011 23:00:31 +0000
Subject: [PATCH] arm/imx: use Kconfig choice for low-level debug UART
 selection
In-Reply-To: <1484610.g1p0X99tcV@wuerfel>
References: <1313530873-24961-1-git-send-email-will.deacon@arm.com>
 <20111122164707.GJ6624@sirena.org.uk>
 <20111122202425.GD9581@n2100.arm.linux.org.uk>
 <1484610.g1p0X99tcV@wuerfel>
Message-ID: <20111122230030.GB3005@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 10:19:53PM +0100, Arnd Bergmann wrote:

> and then selecting DEBUG_LL_LEGACY from all platforms that do their own
> thing. That would avoid the possible randconfig errors.

Your fix seems good to me, and avoids causing hassle for randconfig
folks, though Russell's will be more likely to encourage people to
convert I guess.
