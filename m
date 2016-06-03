From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Jun 2016 12:26:28 -0700
Subject: [linux-sunxi] Re: [PATCH 1/1] devicetree: sunxi: Add OLinuXino
 Lime2 eMMC to the Makefile
In-Reply-To: <20160516144552.GH27618@lukather>
References: <1463169436-6170-1-git-send-email-oliver@schinagl.nl>
 <20160516144552.GH27618@lukather>
Message-ID: <20160603192628.GH3761@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2016 at 04:45:52PM +0200, Maxime Ripard wrote:
> On Fri, May 13, 2016 at 09:57:16PM +0200, Olliver Schinagl wrote:
> > commit 27dd9af6bc000ab21fd ("ARM: dts: sunxi: Add a olinuxino-lime2-emmc")
> > added the new emmc equipped lime2 but forgot its Makefile.
> > 
> > This patch adds an entry to the Makefile.
> > 
> > Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> 
> Having the version of the patch would be nice too.
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Arnd, Kevin, Olof, could you apply that patch directly for 4.7?

Applied as fix now, but with the patch subject fixed up (ARM: dts: sunxi: ...).


-Olof

> 
> Thanks,
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
