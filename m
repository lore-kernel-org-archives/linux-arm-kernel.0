From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 21 Jan 2010 15:47:16 +0200
Subject: [PATCH 0/3] mx25: NAND support
In-Reply-To: <20100114102440.GE23110@pengutronix.de>
References: <cover.1263460321.git.baruch@tkos.co.il>
	<20100114102440.GE23110@pengutronix.de>
Message-ID: <20100121134716.GH4772@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Thu, Jan 14, 2010 at 11:24:40AM +0100, Sascha Hauer wrote:
> On Thu, Jan 14, 2010 at 11:24:12AM +0200, Baruch Siach wrote:
> > This patch series add support for NAND chips on the i.MX25 platform, using the 
> > recently merged support for this platform in the mxc_nand driver.
> > 
> > I tested this code on the i.MX25 PDK platform.
> > 
> > Baruch Siach (3):
> >   mtd: mxc_nand: add MX25 to Kconfig
> >   mx25: add NAND support
> >   mx25pdk: add NAND device support
> 
> Ok, added to mxc-master.

Should these patches be visible in the mxc-master of the imx/linux-2.6.git 
tree? I don't see them there.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
