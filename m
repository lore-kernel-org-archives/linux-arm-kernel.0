From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 4 Sep 2014 22:08:17 +0200
Subject: [PATCH] ARM: configs: Remove REGULATOR_VIRTUAL_CONSUMER from
 defconfigs
In-Reply-To: <20140902153141.GB15771@beef>
References: <1409486590-23645-1-git-send-email-broonie@kernel.org>
 <20140902153141.GB15771@beef>
Message-ID: <201409042208.17482.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 September 2014, Matt Porter wrote:
> On Sun, Aug 31, 2014 at 01:03:10PM +0100, Mark Brown wrote:
> > The virtual consumer is a test device intended to be used while developing
> > regulator drivers, it should never be used in production. Remove it from
> > all defconfigs to avoid confusion among users.
> > 
> > Signed-off-by: Mark Brown <broonie@kernel.org>
> > ---
> >  arch/arm/configs/bcm_defconfig      | 1 -
> 
> For bcm_defconfig:
> 
> Acked-by: Matt Porter <mporter@linaro.org>
> 

Applied to next/defconfig, thanks!

	Arnd
