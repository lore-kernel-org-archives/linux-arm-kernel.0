From: kgene@kernel.org (kgene at kernel.org)
Date: Tue, 17 Dec 2013 21:26:49 +0900
Subject: [GIT PULL 6/7] Samsung DT for v3.14
In-Reply-To: <20131216171645.GJ3185@sirena.org.uk>
References: <52AE0F9A.3010407@samsung.com>
 <20131216171645.GJ3185@sirena.org.uk>
Message-ID: <117501cefb23$42739020$c75ab060$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> On Mon, Dec 16, 2013 at 05:22:50AM +0900, Kukjin Kim wrote:
> 
> > Samsung DT updates for v3.14
> > - Add support Octa Cores for exynos5420
> >   : populate CPU node entries to 8 Cores
> >   : extend mct to support 8 local interrupts
> > - Update dwmmc nodes for exynos5250 and exynos5420
> >   : change status property of dwmmc nodes for exynos5250
> >   : move dwmmc nodes from exynos5 to exynos5250 because
> >     it's different between exynos5250 and exynos5420
> >   : rename mmc nodes from dwmmc for exynos5 SoCs
> >   : add dwmmc nodes for exynos5420
> > - Add G-Scaler nodes for exynos5420
> > - Add HS-i2c nodes in exynos5420
> >   : High Speed I2C 7 channels (4 to 10)
> > - Update sysreg binding and node name in exynos4
> > - Update min voltage on exynos5250-arndale
> > - Move fifo-depth property from boards to exynos5250 SoC
> >   : because the fifo-depth property is SoC specific
> 
> I've been sending updates to disable the I2C and SPI devices by default
> on 5250 for some time now - is there any chance of getting them
> included?

Probably, yes and I will send out 2nd round for v3.14 in this weekend before
rc5 release ;-)

Thanks,
Kukjin
