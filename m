From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Nov 2012 18:49:40 +0900
Subject: [PATCH] ARM: exynos: add UART3 to DEBUG_LL ports
In-Reply-To: <20121121072959.GK7615@quad.lixom.net>
References: <1353451739-6317-1-git-send-email-dianders@chromium.org>
 <20121121072959.GK7615@quad.lixom.net>
Message-ID: <0dff01cdc7cd$86b14500$9413cf00$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> On Tue, Nov 20, 2012 at 02:48:58PM -0800, Doug Anderson wrote:
> > From: Olof Johansson <olof@lixom.net>
> >
> > UART3 is used for debugging on exynos5250-snow.
> >
> > [dianders: cleaned commit message.]
> >
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> > Signed-off-by: Doug Anderson <dianders@chromium.org>
> 
> >
> > ---
> >  arch/arm/Kconfig.debug        |   11 +++++++++++
> >  arch/arm/plat-samsung/Kconfig |    1 +
> >  2 files changed, 12 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
> > index 33a8930..35ba7dc 100644
> > --- a/arch/arm/Kconfig.debug
> > +++ b/arch/arm/Kconfig.debug
> > @@ -355,6 +355,17 @@ choice
> >  		  The uncompressor code port configuration is now handled
> >  		  by CONFIG_S3C_LOWLEVEL_UART_PORT.
> >
> > +	config DEBUG_S3C_UART3
> > +		depends on PLAT_SAMSUNG
> 
> 
> Sorry, the reason I hadn't re-posted this is that Kukjin had proposed
> to protect users of <= 3 UART platforms to select it. An added "Depends
> on ARCH_EXYNOS4 || ARCH_EXYNOS5" should cover that. Can you add and
> repost, please?
> 
Yes, please :-)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
