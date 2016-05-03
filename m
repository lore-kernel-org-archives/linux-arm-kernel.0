From: christo.radev@gmail.com (christo.radev at gmail.com)
Date: Tue, 3 May 2016 08:02:12 -0700 (PDT)
Subject: [PATCH 1/1] ARM: dts: sunxi: Add a olinuxino-lime2-emmc
In-Reply-To: <20160503131437.GV17159@lukather>
References: <1461827998-12192-1-git-send-email-oliver@schinagl.nl>
 <f3da30a6-9ac0-4d5e-8611-ebb80cb3589e@googlegroups.com>
 <20160503131437.GV17159@lukather>
Message-ID: <66e4c452-1e34-474b-8973-2d57d9f036d0@googlegroups.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, May 3, 2016 at 4:14:41 PM UTC+3, Maxime Ripard wrote:
> Hi,
> 
> On Tue, May 03, 2016 at 4:12:06 PM UTC+3, Christo Radev wrote:
> > Hi to All,
> > 
> > I have already solved and tested this issue on Armbian build.  Find
> > patches for both legacy (3.4.111) and mainline (4.5.2) kernels on:
> > http://forum.armbian.com/index.php/topic/853-armbian-customization/page-2#entry7494
> > There it is also described how to do eMMC bootable and much more.
> > 
> > About the board - Olimex already sold all 3 kinds after migration to
> > their HW rev. E. One have to specify Lime2-eMMC as
> > A20-Olinuxino-Lime2-eMMC instead of their old 2 options
> > A20-Olinuxino-Lime2(-4GB).
> 
> Interesting, you have a link to that device?
> 
> Thanks,
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

I have really 2 boards delivered by their local distributor.

Unfortunately, they do not update their site. Use the link for NAND option:
https://www.olimex.com/Products/OLinuXino/A20/A20-OLinuXIno-LIME2-4GB/open-source-hardware
There you can find Users Manual where it is described that eMMC option is available from HW rev. D. The schematic for HW rev. E is also available on their repository:
https://github.com/OLIMEX/OLINUXINO/tree/master/HARDWARE/A20-OLinuXino-LIME2

On the board both 4GB NAND and eMMC Flash chips can be placed alternatively on the same place. There is difference in some other components as well.

If one want to order it from the site probably has to order A20-Olinuxino-Lime2-4GB with note that eMMC option is required. The price is the same.
