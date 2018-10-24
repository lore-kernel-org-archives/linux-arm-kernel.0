From: jagan@amarulasolutions.com (Jagan Teki)
Date: Wed, 24 Oct 2018 13:52:37 +0530
Subject: [linux-sunxi] Re: [PATCH] arm64: defconfig: Enable MFD_AXP20X_I2C
In-Reply-To: <20180731134036.mzgntiv6fwxg2vja@flea>
References: <20180731133828.2582-1-jagan@amarulasolutions.com>
 <20180731134036.mzgntiv6fwxg2vja@flea>
Message-ID: <CAMty3ZC2==BYChib71qyzd7oRkUHB3hunKw2FGRj3t=U2vK5nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 31, 2018 at 7:10 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Jul 31, 2018 at 07:08:28PM +0530, Jagan Teki wrote:
> > The Allwinner H6 SoC is paired with the X-Powers AXP805 PMIC
> > connected via I2C.
> >
> > Enable the driver for this PMIC.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>
> Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Can you apply this? needed for mmc to detect on H6
