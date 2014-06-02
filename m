From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 Jun 2014 11:17:23 +0200
Subject: [PATCH V4] mmc: mmci: Enforce DMA configuration through DT
In-Reply-To: <CAPDyKFrRP-0EZzzyfxinYDp+aPca-t0Gmw3i2tdjM=dX-DXT4w@mail.gmail.com>
References: <1400561154-17846-1-git-send-email-ulf.hansson@linaro.org>
 <CAPDyKFrRP-0EZzzyfxinYDp+aPca-t0Gmw3i2tdjM=dX-DXT4w@mail.gmail.com>
Message-ID: <4964687.xgf1CmDf7Y@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 May 2014 12:50:36 Ulf Hansson wrote:
> On 20 May 2014 06:45, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > Remove the option to provide DMA configuration as platform data,
> > enforce it through DT.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Roland Stigge <stigge@antcom.de>


For the mach-lpc32xx part:

Acked-by: Arnd Bergmann <arnd@arndb.de>

In fact, I had done the same patch for arch/arm/mach-lpc32xx/phy3250.c
myself after hitting the build error on linux-next. Thanks for taking
care of it!

        Arnd
