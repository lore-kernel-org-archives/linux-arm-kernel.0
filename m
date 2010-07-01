From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 1 Jul 2010 08:00:03 +0300
Subject: [PATCHv4 1/3] mx2_camera: Add soc_camera support for i.MX25/i.MX27
In-Reply-To: <Pine.LNX.4.64.1006301058170.17489@axis700.grange>
References: <cover.1277096909.git.baruch@tkos.co.il>
	<03d6e55c39690618e92a91a580ec34549a135c79.1277096909.git.baruch@tkos.co.il>
	<20100630070717.GA11746@pengutronix.de>
	<Pine.LNX.4.64.1006300918190.17489@axis700.grange>
	<20100630072808.GD11746@pengutronix.de>
	<Pine.LNX.4.64.1006301058170.17489@axis700.grange>
Message-ID: <20100701050002.GB16981@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guennadi,

On Wed, Jun 30, 2010 at 11:08:41AM +0200, Guennadi Liakhovetski wrote:

[snip]

> In any case, I'm fine with the patch as it is, so, here's
> 
> Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks for your thorough review and ack.

> I think, it would be better if you, Uwe, or Sascha pull all these 3 patches 
> via one of your tree, because patches 2/3 and 3/3 are ARM/MX2 stuff anyway 
> and this patch changes some files under arch/arm and collides with some mx2 
> changes.

Patches 2/3 and 3/3 are already in the imx-for-2.6.36 branch.

baruch

> Mauro, do you agree? Do we need your ack too? So, taking them all 
> via IMX/MXC would make synchronisation easier. However, if you change 
> anything under drivers/media (including Makefile / Kconfig) or 
> include/media, please let me know, so that I can ack it again.

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
