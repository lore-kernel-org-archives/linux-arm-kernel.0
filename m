From: manu@bidouilliste.com (Emmanuel Vadot)
Date: Thu, 26 Jul 2018 10:00:28 +0200
Subject: [PATCH] arm64: dts: allwinner: activate spi flash on pine64 LTS
 board
In-Reply-To: <20180726073138.fexu4nxaamqmrbzb@flea>
References: <Akash_Gajjar@mentor.com>
 <1532587906-5415-1-git-send-email-Akash_Gajjar@mentor.com>
 <20180726072924.bnvljmd2sf6bf5ae@flea>
 <20180726073138.fexu4nxaamqmrbzb@flea>
Message-ID: <20180726100028.071eae1c96fbe1e013b871b9@bidouilliste.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Jul 2018 09:31:38 +0200
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> On Thu, Jul 26, 2018 at 09:29:24AM +0200, Maxime Ripard wrote:
> > 1;5202;0c
> > On Thu, Jul 26, 2018 at 12:21:46PM +0530, Akash Gajjar wrote:
> > > This board has SPI flash. add spi flash support in device tree.
> > > Tested on pine64 LTS.
> > > 
> > > Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
> > 
> > Queued for 4.20, thanks!
> 
> No, sorry, I ended up droping that patch.
> 
> You mention that the Pine64 LTS has an SPI flash, yet you change the
> sopine baseboard dts. Why is that?

 There is still no dts for Pine64-LTS (Andre latest serie address that).
 Note that the sopine.dtsi already have the SPI node, the patch is
present in sunxi/dt64-for-4.19

> Maxime
> 
> -- 
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com


-- 
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
